document.addEventListener('DOMContentLoaded', () => {
    // Basic Elements
    const productContainer = document.getElementById('product-container');
    const navLinks = document.querySelectorAll('#nav a');
    const accountIcon = document.getElementById('account-icon');
    const closeBtns = document.querySelectorAll('.close-btn');
    
    // Auth Overlays
    const loginOverlay = document.getElementById('login-overlay');
    const profileOverlay = document.getElementById('profile-overlay');
    const passwordOverlay = document.getElementById('password-overlay');

    // Forms
    const loginForm = document.getElementById('login-form');
    const profileForm = document.getElementById('profile-form');
    const passwordForm = document.getElementById('password-form');
    
    // Dropdown Elements
    const userDropdown = document.getElementById('user-dropdown');
    const dropName = document.getElementById('dropdown-user-name');
    const dropRole = document.getElementById('dropdown-user-role');
    const logoutLink = document.getElementById('logout-link');
    const adminLink = document.getElementById('admin-link');
    const editProfileLink = document.getElementById('edit-profile-link');
    const changePassLink = document.getElementById('change-pass-link');

    // Admin Panel Elements
    const adminPanel = document.getElementById('admin-panel');
    const tabBtns = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');
    const userListBody = document.getElementById('admin-user-list');
    const productListBody = document.getElementById('admin-product-list');

    let allProducts = [];
    let currentUser = JSON.parse(localStorage.getItem('pbl3_user')) || null;

    // Khởi tạo UI
    updateAuthUI();

    // Load sản phẩm
    fetch('../../Data/products.json')
        .then(res => res.json())
        .then(products => {
            allProducts = products;
            renderProducts(allProducts);
            if (currentUser) renderAdminProductList();
        });

    // Event Listeners
    accountIcon.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        if (!currentUser) loginOverlay.classList.remove('hidden');
        else userDropdown.classList.toggle('hidden');
    });

    window.addEventListener('click', () => userDropdown.classList.add('hidden'));

    closeBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            loginOverlay.classList.add('hidden');
            profileOverlay.classList.add('hidden');
            passwordOverlay.classList.add('hidden');
        });
    });

    // Link Modal Events
    editProfileLink.addEventListener('click', (e) => {
        e.preventDefault();
        // Điền sẵn thông tin
        document.getElementById('edit-name').value = currentUser.ho_ten;
        document.getElementById('edit-email').value = currentUser.email;
        
        // Nếu là khách hàng, thử tìm SĐT trong customers.json
        if (currentUser.role === 'Khách hàng') {
            fetch('../../Data/customers.json')
                .then(res => res.json())
                .then(customers => {
                    const customer = customers.find(c => c.ten_khach === currentUser.ho_ten);
                    if (customer) document.getElementById('edit-phone').value = customer.sdt;
                    else document.getElementById('edit-phone').value = '';
                });
        }
        
        profileOverlay.classList.remove('hidden');
    });

    changePassLink.addEventListener('click', (e) => {
        e.preventDefault();
        passwordOverlay.classList.remove('hidden');
    });

    // Form Submissions
    loginForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const usernameInput = document.getElementById('username').value;
        const passwordInput = document.getElementById('password').value;

        fetch('../../Data/users.json')
            .then(res => res.json())
            .then(users => {
                const user = users.find(u => u.username === usernameInput && u.password === passwordInput);
                if (user) {
                    localStorage.setItem('pbl3_user', JSON.stringify(user));
                    location.reload(); 
                } else {
                    document.getElementById('login-error').classList.remove('hidden');
                }
            });
    });

    profileForm.addEventListener('submit', (e) => {
        e.preventDefault();
        currentUser.ho_ten = document.getElementById('edit-name').value;
        currentUser.email = document.getElementById('edit-email').value;
        // Giả lập lưu vào localStorage
        localStorage.setItem('pbl3_user', JSON.stringify(currentUser));
        alert('Cập nhật thông tin thành công!');
        location.reload();
    });

    passwordForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const newPass = document.getElementById('new-password').value;
        const confirmPass = document.getElementById('confirm-password').value;
        const errorMsg = document.getElementById('pass-error');

        if (newPass !== confirmPass) {
            errorMsg.classList.remove('hidden');
        } else {
            currentUser.password = newPass;
            localStorage.setItem('pbl3_user', JSON.stringify(currentUser));
            alert('Đổi mật khẩu thành công!');
            location.reload();
        }
    });

    logoutLink.addEventListener('click', (e) => {
        e.preventDefault();
        localStorage.removeItem('pbl3_user');
        location.reload();
    });

    // UI Helper Functions
    function updateAuthUI() {
        if (currentUser) {
            dropName.textContent = currentUser.ho_ten;
            dropRole.textContent = currentUser.role;

            if (currentUser.role === 'Quản trị viên' || currentUser.role === 'Nhân viên') {
                adminPanel.classList.remove('hidden');
                adminLink.classList.remove('hidden');
                renderAdminProductList();
                
                if (currentUser.role === 'Quản trị viên') {
                    document.getElementById('users-tab-btn').classList.remove('hidden');
                    renderUserList();
                } else {
                    document.getElementById('users-tab-btn').classList.add('hidden');
                }
            }
        }
    }

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const target = btn.getAttribute('data-tab');
            tabBtns.forEach(b => b.classList.toggle('active', b === btn));
            tabContents.forEach(c => c.classList.toggle('active', c.id === target));
        });
    });

    function renderUserList() {
        fetch('../../Data/users.json')
            .then(res => res.json())
            .then(users => {
                userListBody.innerHTML = users.map(u => `
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.ho_ten}</td>
                        <td>${u.username}</td>
                        <td><code>${u.password}</code></td>
                        <td><span class="role-badge ${getRoleClass(u.role)}">${u.role}</span></td>
                    </tr>
                `).join('');
            });
    }

    function renderAdminProductList() {
        productListBody.innerHTML = allProducts.map(p => `
            <tr>
                <td>${p.sku}</td>
                <td>${p.ten_san_pham}</td>
                <td>${p.danh_muc}</td>
                <td>${new Intl.NumberFormat('vi-VN').format(p.gia_ban)}đ</td>
                <td>${p.ton_kho}</td>
                <td>
                    <button class="edit-btn"><i class="fa-solid fa-pen"></i></button>
                    <button class="delete-btn"><i class="fa-solid fa-trash"></i></button>
                </td>
            </tr>
        `).join('');
    }

    function getRoleClass(role) {
        return role === 'Quản trị viên' ? 'role-admin' : (role === 'Nhân viên' ? 'role-employee' : 'role-customer');
    }

    function renderProducts(products) {
        productContainer.innerHTML = products.length ? '' : '<p class="loading-text">Không có sản phẩm.</p>';
        products.forEach(p => {
            const card = document.createElement('div');
            card.className = 'product-card';
            card.innerHTML = `
                <div class="product-img"><img src="https://via.placeholder.com/200x200?text=PBL3"></div>
                <div class="product-info">
                    <p class="product-category">${p.danh_muc}</p>
                    <h3 class="product-name">${p.ten_san_pham}</h3>
                    <p class="product-price">${new Intl.NumberFormat('vi-VN').format(p.gia_ban)}đ</p>
                    <button class="add-to-cart-btn">Thêm vào giỏ</button>
                </div>
            `;
            productContainer.appendChild(card);
        });
    }

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            const cat = link.getAttribute('data-category');
            if (cat) {
                e.preventDefault();
                renderProducts(cat === 'all' ? allProducts : allProducts.filter(p => p.danh_muc === cat));
            }
        });
    });
});
