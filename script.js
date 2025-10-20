	// INDEX PAGE LOGIC: Sign Up button click
	const signupBtn = document.getElementById('signupBtn');
	if (signupBtn) {
		signupBtn.addEventListener('click', function () {
			window.location.href = 'signup.html';
		});
	}


// User database: load from localStorage or use default
function getUsers() {
	// Always include default users if not present
	const defaults = [
		{
			username: 'user',
			password: 'pass',
			name: 'John Doe',
			checking: 1532.45,
			savings: 8200.00,
			credit: -320.12
		},
		{
			username: 'jane',
			password: 'doe123',
			name: 'Jane Doe',
			checking: 245.67,
			savings: 12000.50,
			credit: -1200.00
		},
		{
			username: 'Admin',
			password: 'P@ssw0rd',
			name: 'Admin',
			checking: 0,
			savings: 0,
			credit: 0
		}
	];
	let users = [];
	const local = localStorage.getItem('bankUsers');
	if (local) {
		users = JSON.parse(local);
		// Add any missing default users
		defaults.forEach(def => {
			if (!users.some(u => u.username === def.username)) {
				users.push(def);
			}
		});
		saveUsers(users);
	} else {
		users = [...defaults];
		saveUsers(users);
	}
	return users;
}

function saveUsers(users) {
	localStorage.setItem('bankUsers', JSON.stringify(users));
}

document.addEventListener('DOMContentLoaded', function () {
	// SIGNUP PAGE LOGIC
	const signupForm = document.getElementById('signupForm');
	if (signupForm) {
		const errorMsg = document.getElementById('signupError');
		const successMsg = document.getElementById('signupSuccess');
		signupForm.addEventListener('submit', function (e) {
			e.preventDefault();
			const name = document.getElementById('signupName').value.trim();
			const username = document.getElementById('signupUsername').value.trim();
			const password = document.getElementById('signupPassword').value;
			errorMsg.style.display = 'none';
			successMsg.style.display = 'none';
			if (!name || !username || !password) {
				errorMsg.textContent = 'Please fill out all fields.';
				errorMsg.style.display = 'block';
				return;
			}
			let users = getUsers();
			if (users.some(u => u.username === username)) {
				errorMsg.textContent = 'Username already exists.';
				errorMsg.style.display = 'block';
				return;
			}
			// Add new user with default balances
			const newUser = {
				username,
				password,
				name,
				checking: 0.00,
				savings: 0.00,
				credit: 0.00
			};
			users.push(newUser);
			saveUsers(users);
			successMsg.textContent = 'Account created! You can now log in.';
			successMsg.style.display = 'block';
			signupForm.reset();
		});
	}

	// LOGIN PAGE LOGIC
	const loginForm = document.getElementById('loginForm');
	if (loginForm) {
		const errorMsg = document.getElementById('loginError');
		loginForm.addEventListener('submit', function (e) {
			e.preventDefault();
			const username = document.getElementById('username').value.trim();
			const password = document.getElementById('password').value;
			if (!username || !password) {
				errorMsg.textContent = 'Please enter both username and password.';
				errorMsg.style.display = 'block';
				return;
			}
			const users = getUsers();
			const user = users.find(u => u.username === username && u.password === password);
			if (user) {
				errorMsg.style.display = 'none';
				sessionStorage.setItem('bankUser', JSON.stringify(user));
				window.location.href = 'dashboard.html';
			} else {
				errorMsg.textContent = 'Invalid username or password.';
				errorMsg.style.display = 'block';
			}
		});
	}

	// INDEX PAGE LOGIC: Login button click
	const loginBtn = document.getElementById('loginBtn');
	if (loginBtn) {
		loginBtn.addEventListener('click', function () {
			window.location.href = 'login.html';
		});
	}

	// DASHBOARD PAGE LOGIC
		if (document.body.classList.contains('dashboard-page')) {
			const userData = sessionStorage.getItem('bankUser');
			if (!userData) {
				window.location.href = 'login.html';
				return;
			}
			const user = JSON.parse(userData);
			// Admin dashboard
			if (user.username === 'Admin') {
				document.getElementById('dashboard-title').textContent = 'Admin Dashboard';
				document.getElementById('userName').textContent = user.name;
				// Hide account summary, show admin table
				const acctSummary = document.querySelector('.account-summary');
				if (acctSummary) acctSummary.style.display = 'none';
				// Create admin table if not present
				let adminTable = document.getElementById('adminUserTable');
				if (!adminTable) {
					adminTable = document.createElement('table');
					adminTable.id = 'adminUserTable';
					adminTable.innerHTML = `
						<thead>
							<tr>
								<th>Name</th>
								<th>Username</th>
								<th>Checking</th>
								<th>Savings</th>
								<th>Credit</th>
							</tr>
						</thead>
						<tbody></tbody>
					`;
					document.getElementById('dashboard').appendChild(adminTable);
				}
				// Fill table with all users except admin
				const users = getUsers().filter(u => u.username !== 'Admin');
				const tbody = adminTable.querySelector('tbody');
				tbody.innerHTML = '';
				users.forEach(u => {
					const row = document.createElement('tr');
					row.innerHTML = `
						<td>${u.name}</td>
						<td>${u.username}</td>
						<td>$${u.checking.toFixed(2)}</td>
						<td>$${u.savings.toFixed(2)}</td>
						<td>$${u.credit.toFixed(2)}</td>
					`;
					tbody.appendChild(row);
				});
			} else {
				// Regular user dashboard
				document.getElementById('userName').textContent = user.name;
				document.getElementById('checkingBalance').textContent = `$${user.checking.toFixed(2)}`;
				document.getElementById('savingsBalance').textContent = `$${user.savings.toFixed(2)}`;
				document.getElementById('creditBalance').textContent = `$${user.credit.toFixed(2)}`;
			}
			// Logout button
			const logoutBtn = document.getElementById('logoutBtn');
			if (logoutBtn) {
				logoutBtn.addEventListener('click', function () {
					sessionStorage.removeItem('bankUser');
					window.location.href = 'login.html';
				});
			}
		}
});
