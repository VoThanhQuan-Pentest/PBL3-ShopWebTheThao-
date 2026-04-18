document.addEventListener('DOMContentLoaded', () => {
    const API_BASE = '/api';
    const TOKEN_KEY = 'pbl3_token';
    const USER_KEY = 'pbl3_user';
    const CART_KEY = 'pbl3_cart';

    const productContainer = document.getElementById('product-container');
    const navLinks = document.querySelectorAll('#nav a');
    const searchInput = document.getElementById('search-input');
    const accountIcon = document.getElementById('account-icon');
    const cartLink = document.getElementById('cart-link');
    const cartCount = document.getElementById('cart-count');

    const loginOverlay = document.getElementById('login-overlay');
    const profileOverlay = document.getElementById('profile-overlay');
    const passwordOverlay = document.getElementById('password-overlay');
    const productOverlay = document.getElementById('product-overlay');

    const loginForm = document.getElementById('login-form');
    const profileForm = document.getElementById('profile-form');
    const passwordForm = document.getElementById('password-form');
    const productForm = document.getElementById('product-form');

    const userDropdown = document.getElementById('user-dropdown');
    const dropName = document.getElementById('dropdown-user-name');
    const dropRole = document.getElementById('dropdown-user-role');
    const logoutLink = document.getElementById('logout-link');
    const adminLink = document.getElementById('admin-link');
    const editProfileLink = document.getElementById('edit-profile-link');
    const changePassLink = document.getElementById('change-pass-link');

    const adminPanel = document.getElementById('admin-panel');
    const tabBtns = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');
    const userListBody = document.getElementById('admin-user-list');
    const productListBody = document.getElementById('admin-product-list');
    const addProductBtn = document.getElementById('add-product-btn');

    const productFormTitle = document.getElementById('product-form-title');
    const productError = document.getElementById('product-error');
    const loginError = document.getElementById('login-error');
    const passError = document.getElementById('pass-error');

    const overlays = [loginOverlay, profileOverlay, passwordOverlay, productOverlay];

    let token = localStorage.getItem(TOKEN_KEY) || '';
    let currentUser = readStorage(USER_KEY);
    let allProducts = [];
    let currentCategory = 'all';
    let currentQuery = '';
    let editingProduct = null;

    bindEvents();
    bootstrap();

    async function bootstrap() {
        updateCartCount();
        await restoreSession();
        updateAuthUI();
        await loadProducts();
    }

    function bindEvents() {
        accountIcon.addEventListener('click', event => {
            event.preventDefault();
            event.stopPropagation();

            if (!currentUser) {
                openOverlay(loginOverlay);
                return;
            }

            userDropdown.classList.toggle('hidden');
        });

        cartLink.addEventListener('click', event => {
            event.preventDefault();
            const cartItems = readStorage(CART_KEY, []);
            if (!cartItems.length) {
                alert('Giỏ hàng của bạn đang trống.');
                return;
            }
            alert(`Bạn đang có ${cartItems.length} sản phẩm trong giỏ hàng tạm.`);
        });

        window.addEventListener('click', event => {
            if (!userDropdown.contains(event.target) && !accountIcon.contains(event.target)) {
                userDropdown.classList.add('hidden');
            }

            overlays.forEach(overlay => {
                if (event.target === overlay) {
                    closeOverlay(overlay);
                }
            });
        });

        document.querySelectorAll('.close-btn').forEach(button => {
            button.addEventListener('click', () => {
                const overlay = button.closest('.overlay');
                if (overlay) {
                    closeOverlay(overlay);
                }
            });
        });

        document.getElementById('cancel-product').addEventListener('click', () => closeOverlay(productOverlay));

        editProfileLink.addEventListener('click', async event => {
            event.preventDefault();
            if (!currentUser) {
                return;
            }

            try {
                const profile = await apiRequest('/profile');
                document.getElementById('edit-name').value = profile.ho_ten || '';
                document.getElementById('edit-email').value = profile.email || '';
                document.getElementById('edit-phone').value = profile.sdt || '';
                openOverlay(profileOverlay);
            } catch (error) {
                alert(error.message);
            }
        });

        changePassLink.addEventListener('click', event => {
            event.preventDefault();
            passwordForm.reset();
            passError.classList.add('hidden');
            openOverlay(passwordOverlay);
        });

        logoutLink.addEventListener('click', async event => {
            event.preventDefault();
            try {
                if (token) {
                    await apiRequest('/auth/logout', { method: 'POST' });
                }
            } catch (error) {
                console.warn(error);
            } finally {
                clearSession();
                updateAuthUI();
            }
        });

        loginForm.addEventListener('submit', async event => {
            event.preventDefault();
            loginError.classList.add('hidden');

            try {
                const response = await apiRequest('/auth/login', {
                    method: 'POST',
                    auth: false,
                    body: {
                        username: document.getElementById('username').value.trim(),
                        password: document.getElementById('password').value
                    }
                });

                token = response.access_token;
                currentUser = response.user;
                localStorage.setItem(TOKEN_KEY, token);
                localStorage.setItem(USER_KEY, JSON.stringify(currentUser));
                closeOverlay(loginOverlay);
                loginForm.reset();
                updateAuthUI();
                await loadProducts();
            } catch (error) {
                loginError.textContent = error.message;
                loginError.classList.remove('hidden');
            }
        });

        profileForm.addEventListener('submit', async event => {
            event.preventDefault();

            try {
                currentUser = await apiRequest('/profile', {
                    method: 'PUT',
                    body: {
                        ho_ten: document.getElementById('edit-name').value.trim(),
                        email: document.getElementById('edit-email').value.trim(),
                        sdt: document.getElementById('edit-phone').value.trim()
                    }
                });
                localStorage.setItem(USER_KEY, JSON.stringify(currentUser));
                closeOverlay(profileOverlay);
                updateAuthUI();
                alert('Cập nhật thông tin thành công.');
            } catch (error) {
                alert(error.message);
            }
        });

        passwordForm.addEventListener('submit', async event => {
            event.preventDefault();
            passError.classList.add('hidden');

            const currentPassword = document.getElementById('current-password').value;
            const newPassword = document.getElementById('new-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;

            if (newPassword !== confirmPassword) {
                passError.textContent = 'Mật khẩu xác nhận không khớp.';
                passError.classList.remove('hidden');
                return;
            }

            try {
                await apiRequest('/profile/password', {
                    method: 'PUT',
                    body: {
                        current_password: currentPassword,
                        new_password: newPassword,
                        confirm_password: confirmPassword
                    }
                });
                closeOverlay(passwordOverlay);
                passwordForm.reset();
                alert('Đổi mật khẩu thành công.');
            } catch (error) {
                passError.textContent = error.message;
                passError.classList.remove('hidden');
            }
        });

        addProductBtn.addEventListener('click', () => {
            editingProduct = null;
            productForm.reset();
            document.getElementById('product-id').value = '';
            productFormTitle.textContent = 'Thêm sản phẩm';
            productError.classList.add('hidden');
            openOverlay(productOverlay);
        });

        productForm.addEventListener('submit', async event => {
            event.preventDefault();
            productError.classList.add('hidden');

            const payload = {
                ten_san_pham: document.getElementById('product-name').value.trim(),
                sku: document.getElementById('product-sku').value.trim(),
                danh_muc: document.getElementById('product-category').value.trim(),
                thuong_hieu: document.getElementById('product-brand').value.trim(),
                size: document.getElementById('product-size').value.trim(),
                mau: document.getElementById('product-color').value.trim(),
                gia_nhap: Number(document.getElementById('product-cost').value || 0),
                gia_ban: Number(document.getElementById('product-price').value || 0),
                ton_kho: Number(document.getElementById('product-stock').value || 0),
                trang_thai: document.getElementById('product-status').value.trim(),
                link_san_pham: document.getElementById('product-link').value.trim(),
                ghi_chu: document.getElementById('product-note').value.trim()
            };

            try {
                if (editingProduct) {
                    await apiRequest(`/admin/products/${editingProduct.id}`, {
                        method: 'PUT',
                        body: payload
                    });
                } else {
                    await apiRequest('/admin/products', {
                        method: 'POST',
                        body: payload
                    });
                }

                closeOverlay(productOverlay);
                await loadProducts();
            } catch (error) {
                productError.textContent = error.message;
                productError.classList.remove('hidden');
            }
        });

        productListBody.addEventListener('click', async event => {
            const button = event.target.closest('button[data-action]');
            if (!button) {
                return;
            }

            const productId = button.dataset.productId;
            const product = allProducts.find(item => item.id === productId);
            if (!product) {
                return;
            }

            if (button.dataset.action === 'edit') {
                editingProduct = product;
                fillProductForm(product);
                productError.classList.add('hidden');
                productFormTitle.textContent = 'Cập nhật sản phẩm';
                openOverlay(productOverlay);
                return;
            }

            if (button.dataset.action === 'delete') {
                const confirmed = confirm(`Xóa sản phẩm "${product.ten_san_pham}"?`);
                if (!confirmed) {
                    return;
                }

                try {
                    await apiRequest(`/admin/products/${productId}`, { method: 'DELETE' });
                    await loadProducts();
                } catch (error) {
                    alert(error.message);
                }
            }
        });

        navLinks.forEach(link => {
            link.addEventListener('click', event => {
                const category = link.getAttribute('data-category');
                if (!category) {
                    return;
                }

                event.preventDefault();
                currentCategory = category;
                renderProducts(getFilteredProducts());
            });
        });

        searchInput.addEventListener('input', () => {
            currentQuery = searchInput.value.trim();
            renderProducts(getFilteredProducts());
        });

        tabBtns.forEach(button => {
            button.addEventListener('click', () => {
                const target = button.getAttribute('data-tab');
                tabBtns.forEach(item => item.classList.toggle('active', item === button));
                tabContents.forEach(content => content.classList.toggle('active', content.id === target));
            });
        });

        productContainer.addEventListener('click', event => {
            const button = event.target.closest('.add-to-cart-btn');
            if (!button) {
                return;
            }

            const productId = button.dataset.productId;
            addToCart(productId);
        });
    }

    async function restoreSession() {
        if (!token) {
            currentUser = null;
            return;
        }

        try {
            currentUser = await apiRequest('/auth/me');
            localStorage.setItem(USER_KEY, JSON.stringify(currentUser));
        } catch (error) {
            clearSession();
        }
    }

    async function loadProducts() {
        productContainer.innerHTML = '<p class="loading-text">Đang tải sản phẩm...</p>';

        try {
            allProducts = await apiRequest('/products', { auth: false });
            renderProducts(getFilteredProducts());
            renderAdminProductList();
            if (isAdmin()) {
                await renderUserList();
            } else {
                userListBody.innerHTML = '';
            }
        } catch (error) {
            productContainer.innerHTML = `<p class="error-text">${error.message}</p>`;
        }
    }

    function renderProducts(products) {
        if (!products.length) {
            productContainer.innerHTML = '<p class="loading-text">Không có sản phẩm phù hợp.</p>';
            return;
        }

        productContainer.innerHTML = products.map(product => {
            const badge = product.ton_kho <= 3
                ? '<span class="badge danger">Sắp hết</span>'
                : (product.ton_kho <= 10 ? '<span class="badge warning">Bán chạy</span>' : '');

            return `
                <div class="product-card">
                    <div class="product-img">
                        ${badge}
                        <img src="https://via.placeholder.com/200x200?text=PBL3" alt="${escapeHtml(product.ten_san_pham)}">
                    </div>
                    <div class="product-info">
                        <p class="product-category">${escapeHtml(product.danh_muc || '')}</p>
                        <h3 class="product-name">${escapeHtml(product.ten_san_pham || '')}</h3>
                        <div class="product-meta">
                            <span>${escapeHtml(product.thuong_hieu || 'Không rõ')}</span>
                            <span>${escapeHtml(product.size || '--')}</span>
                        </div>
                        <p class="product-price">${formatCurrency(product.gia_ban)}</p>
                        <p class="product-stock">Tồn kho: ${product.ton_kho ?? 0}</p>
                        <button class="add-to-cart-btn" data-product-id="${product.id}">Thêm vào giỏ</button>
                    </div>
                </div>
            `;
        }).join('');
    }

    function renderAdminProductList() {
        if (!canManageProducts()) {
            productListBody.innerHTML = '';
            return;
        }

        productListBody.innerHTML = allProducts.map(product => `
            <tr>
                <td>${escapeHtml(product.sku || '')}</td>
                <td>${escapeHtml(product.ten_san_pham || '')}</td>
                <td>${escapeHtml(product.danh_muc || '')}</td>
                <td>${formatCurrency(product.gia_ban)}</td>
                <td>${product.ton_kho ?? 0}</td>
                <td>
                    <button class="edit-btn" data-action="edit" data-product-id="${product.id}"><i class="fa-solid fa-pen"></i></button>
                    <button class="delete-btn" data-action="delete" data-product-id="${product.id}"><i class="fa-solid fa-trash"></i></button>
                </td>
            </tr>
        `).join('');
    }

    async function renderUserList() {
        try {
            const users = await apiRequest('/admin/users');
            userListBody.innerHTML = users.map(user => `
                <tr>
                    <td>${escapeHtml(user.id || '')}</td>
                    <td>${escapeHtml(user.ho_ten || '')}</td>
                    <td>${escapeHtml(user.username || '')}</td>
                    <td>${escapeHtml(user.email || '')}</td>
                    <td>${escapeHtml(user.sdt || '')}</td>
                    <td><span class="role-badge ${getRoleClass(user.role)}">${escapeHtml(user.role || '')}</span></td>
                </tr>
            `).join('');
        } catch (error) {
            userListBody.innerHTML = `<tr><td colspan="6" class="error-text">${escapeHtml(error.message)}</td></tr>`;
        }
    }

    function updateAuthUI() {
        const authenticated = Boolean(currentUser);

        if (!authenticated) {
            adminPanel.classList.add('hidden');
            adminLink.classList.add('hidden');
            userDropdown.classList.add('hidden');
            dropName.textContent = 'Khách';
            dropRole.textContent = 'Vai trò';
            return;
        }

        dropName.textContent = currentUser.ho_ten || 'Người dùng';
        dropRole.textContent = currentUser.role || 'Thành viên';

        if (canManageProducts()) {
            adminPanel.classList.remove('hidden');
            adminLink.classList.remove('hidden');
        } else {
            adminPanel.classList.add('hidden');
            adminLink.classList.add('hidden');
        }

        document.getElementById('users-tab-btn').classList.toggle('hidden', !isAdmin());
    }

    function getFilteredProducts() {
        return allProducts.filter(product => {
            const matchesCategory = currentCategory === 'all' || product.danh_muc === currentCategory;
            const haystack = normalizeText([
                product.ten_san_pham,
                product.danh_muc,
                product.thuong_hieu,
                product.sku
            ].filter(Boolean).join(' '));
            const matchesQuery = !currentQuery || haystack.includes(normalizeText(currentQuery));
            return matchesCategory && matchesQuery;
        });
    }

    function fillProductForm(product) {
        document.getElementById('product-id').value = product.id || '';
        document.getElementById('product-name').value = product.ten_san_pham || '';
        document.getElementById('product-sku').value = product.sku || '';
        document.getElementById('product-category').value = product.danh_muc || '';
        document.getElementById('product-brand').value = product.thuong_hieu || '';
        document.getElementById('product-size').value = product.size || '';
        document.getElementById('product-color').value = product.mau || '';
        document.getElementById('product-cost').value = product.gia_nhap ?? 0;
        document.getElementById('product-price').value = product.gia_ban ?? 0;
        document.getElementById('product-stock').value = product.ton_kho ?? 0;
        document.getElementById('product-status').value = product.trang_thai || 'Đang bán';
        document.getElementById('product-link').value = product.link_san_pham || '';
        document.getElementById('product-note').value = product.ghi_chu || '';
    }

    function addToCart(productId) {
        const product = allProducts.find(item => item.id === productId);
        if (!product) {
            return;
        }

        const cartItems = readStorage(CART_KEY, []);
        cartItems.push({
            id: product.id,
            ten_san_pham: product.ten_san_pham,
            gia_ban: product.gia_ban
        });
        localStorage.setItem(CART_KEY, JSON.stringify(cartItems));
        updateCartCount();
        alert(`Đã thêm "${product.ten_san_pham}" vào giỏ hàng tạm.`);
    }

    function updateCartCount() {
        const cartItems = readStorage(CART_KEY, []);
        cartCount.textContent = String(cartItems.length);
    }

    function clearSession() {
        token = '';
        currentUser = null;
        localStorage.removeItem(TOKEN_KEY);
        localStorage.removeItem(USER_KEY);
        userDropdown.classList.add('hidden');
    }

    function openOverlay(overlay) {
        overlay.classList.remove('hidden');
    }

    function closeOverlay(overlay) {
        overlay.classList.add('hidden');
    }

    function canManageProducts() {
        return currentUser && ['Quản trị viên', 'Nhân viên'].includes(currentUser.role);
    }

    function isAdmin() {
        return currentUser && currentUser.role === 'Quản trị viên';
    }

    function getRoleClass(role) {
        if (role === 'Quản trị viên') {
            return 'role-admin';
        }
        if (role === 'Nhân viên') {
            return 'role-employee';
        }
        return 'role-customer';
    }

    async function apiRequest(path, options = {}) {
        const {
            method = 'GET',
            body,
            auth = true
        } = options;

        const headers = {
            'Content-Type': 'application/json'
        };

        if (auth && token) {
            headers.Authorization = `Bearer ${token}`;
        }

        const response = await fetch(`${API_BASE}${path}`, {
            method,
            headers,
            body: body ? JSON.stringify(body) : undefined
        });

        if (response.status === 204) {
            return null;
        }

        const text = await response.text();
        const data = text ? safeJsonParse(text) : null;

        if (!response.ok) {
            const message = data?.message || 'Yêu cầu không thành công.';
            if (response.status === 401) {
                clearSession();
                updateAuthUI();
            }
            throw new Error(message);
        }

        return data;
    }

    function safeJsonParse(text) {
        try {
            return JSON.parse(text);
        } catch (error) {
            return null;
        }
    }

    function readStorage(key, fallback = null) {
        try {
            const raw = localStorage.getItem(key);
            return raw ? JSON.parse(raw) : fallback;
        } catch (error) {
            return fallback;
        }
    }

    function normalizeText(value) {
        return String(value || '')
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toLowerCase();
    }

    function formatCurrency(value) {
        return `${new Intl.NumberFormat('vi-VN').format(Number(value || 0))}đ`;
    }

    function escapeHtml(value) {
        return String(value ?? '')
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            .replaceAll('"', '&quot;')
            .replaceAll("'", '&#39;');
    }
});
