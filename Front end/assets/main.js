document.addEventListener('DOMContentLoaded', () => {
    const API_BASE = '/api';
    const TOKEN_KEY = 'pbl3_token';
    const USER_KEY = 'pbl3_user';
    const CART_KEY = 'pbl3_cart';
    const WISHLIST_KEY = 'pbl3_wishlist';
    const PASSWORD_RULE_MESSAGE = 'Mật khẩu phải có chữ hoa, chữ thường, chữ số và ký tự đặc biệt như @ hoặc #.';

    const SPORT_SECTIONS = normalizePayload([
        {
            sport: 'Bóng đá',
            icon: 'fa-futbol',
            items: [
                { id: 'football-ball', label: 'Bóng thi đấu', panels: ['sports'], keywords: ['bong', 'numero'], exclude: ['giay', 'ao ', 'quan ', 'balo', 'tui', 'ong dong', 'gang tay', 'backpack', 'duffel', 'tat ', 'khan lau', 'towel'] },
                { id: 'football-shoes', label: 'Giày bóng đá', panels: ['sports', 'accessories'], keywords: ['giay'] },
                { id: 'football-apparel', label: 'Quần áo', panels: ['sports', 'apparel'], keywords: ['ao ', 'jersey', 'drill top', 'training pants', 'training jersey', 'quan '] },
                { id: 'football-gloves', label: 'Găng tay', panels: ['accessories'], keywords: ['gang tay'] },
                { id: 'football-shinguards', label: 'Bịt ống đồng', panels: ['accessories'], keywords: ['ong dong', 'guard'] },
                { id: 'football-socks', label: 'Tất bóng đá', panels: ['accessories'], keywords: ['tat '] },
                { id: 'football-towels', label: 'Khăn lau', panels: ['accessories'], keywords: ['khan lau', 'towel'] },
                { id: 'football-backpacks', label: 'Balo thể thao', panels: ['accessories'], keywords: ['balo', 'backpack', 'tui', 'duffel'] }
            ]
        },
        {
            sport: 'Bóng chuyền',
            icon: 'fa-volleyball',
            items: [
                { id: 'volleyball-ball', label: 'Bóng thi đấu', panels: ['sports'], keywords: ['bong'], exclude: ['giay', 'ao ', 'quan ', 'bao ve goi', 'kneepad', 'tat ', 'balo', 'backpack', 'tui', 'khan lau', 'towel'] },
                { id: 'volleyball-shoes', label: 'Giày bóng chuyền', panels: ['sports', 'accessories'], keywords: ['giay'] },
                { id: 'volleyball-apparel', label: 'Quần áo', panels: ['sports', 'apparel'], keywords: ['ao ', 'jersey', 'quan '] },
                { id: 'volleyball-kneepads', label: 'Bảo vệ gối', panels: ['accessories'], keywords: ['bao ve goi', 'kneepad'] },
                { id: 'volleyball-socks', label: 'Tất bóng chuyền', panels: ['accessories'], keywords: ['tat '] },
                { id: 'volleyball-towels', label: 'Khăn lau', panels: ['accessories'], keywords: ['khan lau', 'towel'] },
                { id: 'volleyball-backpacks', label: 'Balo thể thao', panels: ['accessories'], keywords: ['balo', 'backpack', 'tui'] }
            ]
        },
        {
            sport: 'Bóng rổ',
            icon: 'fa-basketball',
            items: [
                { id: 'basketball-ball', label: 'Bóng thi đấu', panels: ['sports'], keywords: ['bong'], exclude: ['giay', 'ao ', 'balo', 'ong tay', 'tat ', 'mini hoop', 'backpack', 'khan lau', 'towel'] },
                { id: 'basketball-shoes', label: 'Giày bóng rổ', panels: ['sports', 'accessories'], keywords: ['giay'] },
                { id: 'basketball-apparel', label: 'Quần áo', panels: ['sports', 'apparel'], keywords: ['ao ', 'sleeveless', 'jersey'] },
                { id: 'basketball-socks', label: 'Tất bóng rổ', panels: ['accessories'], keywords: ['tat '] },
                { id: 'basketball-arm-sleeves', label: 'Ống tay', panels: ['accessories'], keywords: ['ong tay', 'arm sleeve'] },
                { id: 'basketball-towels', label: 'Khăn lau', panels: ['accessories'], keywords: ['khan lau', 'towel'] },
                { id: 'basketball-backpacks', label: 'Balo thể thao', panels: ['accessories'], keywords: ['balo', 'backpack'] },
                { id: 'basketball-training-gear', label: 'Phụ kiện tập luyện', panels: ['accessories'], keywords: ['mini hoop'] }
            ]
        },
        {
            sport: 'Bóng bàn',
            icon: 'fa-table-tennis-paddle-ball',
            items: [
                { id: 'tabletennis-racket', label: 'Vợt bóng bàn', panels: ['sports'], keywords: ['vot'] },
                { id: 'tabletennis-rubber', label: 'Mặt vợt', panels: ['sports', 'accessories'], keywords: ['mat vot'] },
                { id: 'tabletennis-ball', label: 'Bóng thi đấu', panels: ['sports', 'accessories'], keywords: ['bong bong ban', 'premium 40', 'dj40', 'r40'] },
                { id: 'tabletennis-accessories', label: 'Phụ kiện bóng bàn', panels: ['sports', 'accessories'], keywords: ['luoi', 'keo'] },
                { id: 'tabletennis-apparel', label: 'Quần áo', panels: ['apparel'], keywords: ['shirt', 'polo'] }
            ]
        },
        {
            sport: 'Cầu lông',
            icon: 'fa-shuttlecock',
            items: [
                { id: 'badminton-racket', label: 'Vợt cầu lông', panels: ['sports'], keywords: ['vot'] },
                { id: 'badminton-shuttlecock', label: 'Cầu thi đấu', panels: ['sports', 'accessories'], keywords: ['cau long', 'aerosensa', 'mavis', 'master ace', 'no.1'], exclude: ['vot', 'giay', 'cuoc', 'quan can', 'tui'] },
                { id: 'badminton-shoes', label: 'Giày cầu lông', panels: ['sports'], keywords: ['giay'] },
                { id: 'badminton-strings', label: 'Cước và quấn cán', panels: ['sports', 'accessories'], keywords: ['cuoc', 'quan can'] },
                { id: 'badminton-accessories', label: 'Túi và phụ kiện', panels: ['sports', 'accessories'], keywords: ['tui'] },
                { id: 'badminton-apparel', label: 'Quần áo', panels: ['apparel'], keywords: ['shirt', 'shorts'] }
            ]
        }
    ]);

    const COLLECTION_SECTIONS = normalizePayload([
        {
            id: 'hot',
            label: 'Sản phẩm hot',
            eyebrow: 'Xu hướng nổi bật',
            icon: 'fa-fire-flame-curved',
            breadcrumb: 'Trang chủ / Sản phẩm hot',
            description: 'Tuyển chọn các dòng nổi bật đang được hãng đẩy mạnh hoặc xuất hiện trong nhóm top seller, official game ball và current lineup.'
        },
        {
            id: 'shock-sale',
            label: 'Giảm giá cực sâu',
            eyebrow: 'Deal trong ngày',
            icon: 'fa-tags',
            breadcrumb: 'Trang chủ / Giảm giá cực sâu',
            description: 'Tập hợp các mẫu đang bám theo các trang sale, markdown hoặc ưu đãi rõ ràng từ hãng để người dùng săn deal nhanh.'
        },
        {
            id: 'worldcup-2026',
            label: 'WorldCup 2026',
            eyebrow: 'Không khí bóng đá',
            icon: 'fa-trophy',
            breadcrumb: 'Trang chủ / WorldCup 2026',
            description: 'Bộ sưu tập theo tinh thần World Cup: giày, bóng, áo tập và phụ kiện bóng đá từ các line thi đấu và training nổi bật.'
        },
        {
            id: 'seagames-2025',
            label: 'SEAGAMES 2025',
            eyebrow: 'Bộ sưu tập thi đấu',
            icon: 'fa-medal',
            breadcrumb: 'Trang chủ / SEAGAMES 2025',
            description: 'Bộ sưu tập gợi ý theo tinh thần SEA Games, ưu tiên trang phục thi đấu, giày indoor court và phụ kiện vận động viên. Đây là collection biên tập theo ngữ cảnh thi đấu, không phải nhãn chính thức của hãng.'
        }
    ]);

    const COLLECTION_PRODUCT_MAP = {
        hot: [
            'FB-027',
            'FB-010',
            'FB-011',
            'VB-002',
            'VB-011',
            'BM-022',
            'BM-005',
            'TT-017'
        ],
        'shock-sale': [
            'FB-010',
            'FB-011',
            'FB-013',
            'FB-017',
            'FB-019',
            'TT-028'
        ],
        'worldcup-2026': [
            'FB-007',
            'FB-008',
            'FB-009',
            'FB-010',
            'FB-011',
            'FB-012',
            'FB-013',
            'FB-014',
            'FB-015',
            'FB-016',
            'FB-017',
            'FB-018',
            'FB-020',
            'FB-023',
            'FB-025',
            'FB-026',
            'FB-027'
        ],
        'seagames-2025': [
            'VB-010',
            'VB-011',
            'VB-012',
            'VB-015',
            'VB-016',
            'VB-017',
            'VB-018',
            'VB-027',
            'BM-014',
            'BM-015',
            'BM-023',
            'BM-024',
            'TT-028',
            'TT-029',
            'BB-021',
            'BB-024'
        ]
    };

    const productContainer = document.getElementById('product-container');
    const navCollectionLinks = Array.from(document.querySelectorAll('#nav a[data-collection]'));
    const searchInput = document.getElementById('search-input');
    const accountIcon = document.getElementById('account-icon');
    const cartLink = document.getElementById('cart-link');
    const cartCount = document.getElementById('cart-count');
    const wishlistLink = document.getElementById('wishlist-link');
    const wishlistCount = document.getElementById('wishlist-count');
    const catalogTrigger = document.getElementById('catalog-trigger');
    const clearFiltersButton = document.getElementById('clear-filters');
    const activeFilters = document.getElementById('active-filters');
    const catalogToolbar = document.getElementById('catalog-toolbar');
    const catalogTitle = document.getElementById('catalog-title');
    const catalogDescription = document.getElementById('catalog-description');
    const catalogCount = document.getElementById('catalog-count');
    const collectionView = document.getElementById('collection-view');
    const collectionBreadcrumb = document.getElementById('collection-breadcrumb');
    const collectionShortcuts = document.getElementById('collection-shortcuts');
    const collectionEyebrow = document.getElementById('collection-eyebrow');
    const collectionTitle = document.getElementById('collection-title');
    const collectionDescription = document.getElementById('collection-description');
    const collectionCount = document.getElementById('collection-count');
    const priceFilter = document.getElementById('price-filter');
    const typeFilter = document.getElementById('type-filter');
    const brandFilter = document.getElementById('brand-filter');
    const sizeFilter = document.getElementById('size-filter');
    const sortFilter = document.getElementById('sort-filter');
    const logo = document.getElementById('logo');
    const cartView = document.getElementById('cart-view');
    const cartContent = document.getElementById('cart-content');
    const cartEmptyState = document.getElementById('cart-empty-state');
    const cartItemsContainer = document.getElementById('cart-items');
    const cartSelectAllCheckbox = document.getElementById('cart-select-all');
    const cartSelectionSummary = document.getElementById('cart-selection-summary');
    const cartSummaryCount = document.getElementById('cart-summary-count');
    const cartSummarySubtotal = document.getElementById('cart-summary-subtotal');
    const cartSummaryShipping = document.getElementById('cart-summary-shipping');
    const cartSummaryTotal = document.getElementById('cart-summary-total');
    const checkoutBtn = document.getElementById('checkout-btn');
    const removeSelectedBtn = document.getElementById('remove-selected-btn');
    const continueShoppingBtn = document.getElementById('continue-shopping-btn');
    const emptyCartContinueBtn = document.getElementById('empty-cart-continue-btn');
    const wishlistView = document.getElementById('wishlist-view');
    const wishlistGrid = document.getElementById('wishlist-grid');
    const wishlistEmptyState = document.getElementById('wishlist-empty-state');
    const continueFromWishlistBtn = document.getElementById('continue-from-wishlist-btn');
    const wishlistEmptyContinueBtn = document.getElementById('wishlist-empty-continue-btn');

    const megaMenu = document.getElementById('mega-menu');
    const megaTabs = Array.from(document.querySelectorAll('.mega-tab'));
    const megaPanels = {
        sports: document.getElementById('mega-panel-sports'),
        apparel: document.getElementById('mega-panel-apparel'),
        accessories: document.getElementById('mega-panel-accessories'),
        brands: document.getElementById('mega-panel-brands')
    };
    const megaMenuSummary = document.getElementById('mega-menu-summary');
    const megaReset = document.getElementById('mega-reset');

    const loginOverlay = document.getElementById('login-overlay');
    const registerOverlay = document.getElementById('register-overlay');
    const forgotPasswordOverlay = document.getElementById('forgot-password-overlay');
    const profileOverlay = document.getElementById('profile-overlay');
    const passwordOverlay = document.getElementById('password-overlay');
    const productOverlay = document.getElementById('product-overlay');
    const cartItemOverlay = document.getElementById('cart-item-overlay');
    const overlays = [loginOverlay, registerOverlay, forgotPasswordOverlay, profileOverlay, passwordOverlay, productOverlay, cartItemOverlay];

    const loginForm = document.getElementById('login-form');
    const registerForm = document.getElementById('register-form');
    const forgotPasswordForm = document.getElementById('forgot-password-form');
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
    const tabBtns = Array.from(document.querySelectorAll('.tab-btn'));
    const tabContents = Array.from(document.querySelectorAll('.tab-content'));
    const userListBody = document.getElementById('admin-user-list');
    const productListBody = document.getElementById('admin-product-list');
    const addProductBtn = document.getElementById('add-product-btn');

    const productFormTitle = document.getElementById('product-form-title');
    const productError = document.getElementById('product-error');
    const loginError = document.getElementById('login-error');
    const registerError = document.getElementById('register-error');
    const forgotPasswordError = document.getElementById('forgot-password-error');
    const passError = document.getElementById('pass-error');
    const cartItemForm = document.getElementById('cart-item-form');
    const cartItemError = document.getElementById('cart-item-error');
    const cartConfigProductId = document.getElementById('cart-config-product-id');
    const cartConfigImage = document.getElementById('cart-config-image');
    const cartConfigCategory = document.getElementById('cart-config-category');
    const cartConfigName = document.getElementById('cart-config-name');
    const cartConfigBrand = document.getElementById('cart-config-brand');
    const cartConfigPrice = document.getElementById('cart-config-price');
    const cartConfigStock = document.getElementById('cart-config-stock');
    const cartConfigSize = document.getElementById('cart-config-size');
    const cartConfigQuantity = document.getElementById('cart-config-quantity');
    const cartConfigMinus = document.getElementById('cart-config-minus');
    const cartConfigPlus = document.getElementById('cart-config-plus');

    const openRegisterButton = document.getElementById('open-register');
    const openForgotPasswordButton = document.getElementById('open-forgot-password');
    const backToLoginFromRegisterButton = document.getElementById('back-to-login-from-register');
    const backToLoginFromForgotButton = document.getElementById('back-to-login-from-forgot');

    let token = localStorage.getItem(TOKEN_KEY) || '';
    let currentUser = readStorage(USER_KEY);
    let allProducts = [];
    let currentCollectionId = '';
    let currentCategory = 'all';
    let currentMenuItemId = '';
    let currentBrand = '';
    let currentQuery = '';
    let currentPriceRange = 'all';
    let currentTypeFilter = 'all';
    let currentSizeFilter = 'all';
    let currentSortOption = 'featured';
    let activeMegaTab = 'sports';
    let editingProduct = null;
    let currentView = 'catalog';
    let pendingWishlistMoveProductId = '';

    bindEvents();
    bootstrap();

    async function bootstrap() {
        updateCartCount();
        updateWishlistCount();
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
            openCartView();
        });

        wishlistLink.addEventListener('click', event => {
            event.preventDefault();
            openWishlistView();
        });

        logo.addEventListener('click', event => {
            event.preventDefault();
            goToHomePage();
        });

        catalogTrigger.addEventListener('click', event => {
            event.preventDefault();
            event.stopPropagation();
            toggleMegaMenu();
        });

        megaTabs.forEach(tab => {
            tab.addEventListener('click', () => {
                activeMegaTab = tab.dataset.tab;
                syncMegaTabState();
            });
        });

        megaReset.addEventListener('click', () => {
            resetCatalogState({ clearQuery: false });
            closeMegaMenu();
        });

        megaMenu.addEventListener('click', event => {
            const actionTarget = event.target.closest('[data-filter-type]');
            if (!actionTarget) {
                return;
            }

            event.preventDefault();
            const filterType = actionTarget.dataset.filterType;

            if (filterType === 'category') {
                applyCategoryFilter(actionTarget.dataset.category);
            }

            if (filterType === 'item') {
                applyMenuItemFilter(actionTarget.dataset.itemId);
            }

            if (filterType === 'brand') {
                applyBrandFilter(actionTarget.dataset.brand);
            }

            closeMegaMenu();
        });

        clearFiltersButton.addEventListener('click', () => {
            resetCatalogState({ clearQuery: true });
        });

        [priceFilter, typeFilter, brandFilter, sizeFilter, sortFilter].forEach(control => {
            control.addEventListener('change', () => {
                currentPriceRange = priceFilter.value;
                currentTypeFilter = typeFilter.value;
                currentBrand = brandFilter.value === 'all' ? '' : brandFilter.value;
                currentSizeFilter = sizeFilter.value;
                currentSortOption = sortFilter.value;
                renderCatalog();
            });
        });

        activeFilters.addEventListener('click', event => {
            const chipButton = event.target.closest('button[data-clear]');
            if (!chipButton) {
                return;
            }

            const action = chipButton.dataset.clear;
            if (action === 'query') {
                currentQuery = '';
                searchInput.value = '';
            }
            if (action === 'brand') {
                currentBrand = '';
            }
            if (action === 'item') {
                currentMenuItemId = '';
            }
            if (action === 'category') {
                currentCategory = 'all';
            }
            if (action === 'collection') {
                currentCollectionId = '';
                currentPriceRange = 'all';
                currentTypeFilter = 'all';
                currentSizeFilter = 'all';
                currentSortOption = 'featured';
            }
            if (action === 'price') {
                currentPriceRange = 'all';
            }
            if (action === 'type') {
                currentTypeFilter = 'all';
            }
            if (action === 'size') {
                currentSizeFilter = 'all';
            }

            renderCatalog();
        });

        navCollectionLinks.forEach(link => {
            link.addEventListener('click', event => {
                event.preventDefault();
                applyCollectionFilter(link.dataset.collection);
                closeMegaMenu();
            });
        });

        searchInput.addEventListener('input', () => {
            currentQuery = searchInput.value.trim();
            renderCatalog();
        });

        searchInput.addEventListener('focus', () => closeMegaMenu());

        window.addEventListener('click', event => {
            if (!userDropdown.contains(event.target) && !accountIcon.contains(event.target)) {
                userDropdown.classList.add('hidden');
            }

            const clickedInsideMegaMenu = megaMenu.contains(event.target);
            const clickedCatalogTrigger = catalogTrigger.contains(event.target);
            if (!clickedInsideMegaMenu && !clickedCatalogTrigger) {
                closeMegaMenu();
            }

            overlays.forEach(overlay => {
                if (event.target === overlay) {
                    closeOverlay(overlay);
                }
            });
        });

        window.addEventListener('keydown', event => {
            if (event.key === 'Escape') {
                closeMegaMenu();
                overlays.forEach(overlay => closeOverlay(overlay));
                userDropdown.classList.add('hidden');
            }
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
        document.getElementById('cancel-cart-item').addEventListener('click', () => {
            resetCartConfiguratorState();
            closeOverlay(cartItemOverlay);
        });

        continueShoppingBtn.addEventListener('click', showCatalogView);
        emptyCartContinueBtn.addEventListener('click', showCatalogView);
        continueFromWishlistBtn.addEventListener('click', showCatalogView);
        wishlistEmptyContinueBtn.addEventListener('click', showCatalogView);

        cartSelectAllCheckbox.addEventListener('change', () => {
            const cartItems = getCartItems().map(item => ({ ...item, selected: cartSelectAllCheckbox.checked }));
            saveCartItems(cartItems);
            renderCartView();
        });

        checkoutBtn.addEventListener('click', handleCheckout);
        removeSelectedBtn.addEventListener('click', removeSelectedCartItems);

        cartConfigMinus.addEventListener('click', () => {
            const currentValue = Number(cartConfigQuantity.value || 1);
            cartConfigQuantity.value = String(Math.max(1, currentValue - 1));
        });

        cartConfigPlus.addEventListener('click', () => {
            const selectedProduct = allProducts.find(item => item.id === cartConfigProductId.value);
            const maxQuantity = Math.max(1, selectedProduct?.ton_kho ?? 1);
            const currentValue = Number(cartConfigQuantity.value || 1);
            cartConfigQuantity.value = String(Math.min(maxQuantity, currentValue + 1));
        });

        cartItemForm.addEventListener('submit', event => {
            event.preventDefault();
            confirmAddToCart();
        });

        openRegisterButton.addEventListener('click', () => {
            registerForm.reset();
            registerError.classList.add('hidden');
            switchAuthOverlay(registerOverlay);
        });

        openForgotPasswordButton.addEventListener('click', () => {
            forgotPasswordForm.reset();
            forgotPasswordError.classList.add('hidden');
            switchAuthOverlay(forgotPasswordOverlay);
        });

        backToLoginFromRegisterButton.addEventListener('click', () => {
            loginError.classList.add('hidden');
            switchAuthOverlay(loginOverlay);
        });

        backToLoginFromForgotButton.addEventListener('click', () => {
            loginError.classList.add('hidden');
            switchAuthOverlay(loginOverlay);
        });

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
                renderCatalog();
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

                applyLoginSession(response);
                closeOverlay(loginOverlay);
                loginForm.reset();
                updateAuthUI();
                await loadProducts();
            } catch (error) {
                loginError.textContent = error.message;
                loginError.classList.remove('hidden');
            }
        });

        registerForm.addEventListener('submit', async event => {
            event.preventDefault();
            registerError.classList.add('hidden');

            const registerPassword = document.getElementById('register-password').value;
            const registerConfirmPassword = document.getElementById('register-confirm-password').value;

            if (!isStrongPassword(registerPassword)) {
                registerError.textContent = PASSWORD_RULE_MESSAGE;
                registerError.classList.remove('hidden');
                return;
            }

            try {
                const response = await apiRequest('/auth/register', {
                    method: 'POST',
                    auth: false,
                    body: {
                        username: document.getElementById('register-username').value.trim(),
                        ho_ten: document.getElementById('register-name').value.trim(),
                        email: document.getElementById('register-email').value.trim(),
                        sdt: document.getElementById('register-phone').value.trim(),
                        password: registerPassword,
                        confirm_password: registerConfirmPassword
                    }
                });

                applyLoginSession(response);
                closeOverlay(registerOverlay);
                registerForm.reset();
                updateAuthUI();
                await loadProducts();
                alert('Đăng ký thành công.');
            } catch (error) {
                registerError.textContent = error.message;
                registerError.classList.remove('hidden');
            }
        });

        forgotPasswordForm.addEventListener('submit', async event => {
            event.preventDefault();
            forgotPasswordError.classList.add('hidden');

            const forgotNewPassword = document.getElementById('forgot-new-password').value;
            if (!isStrongPassword(forgotNewPassword)) {
                forgotPasswordError.textContent = PASSWORD_RULE_MESSAGE;
                forgotPasswordError.classList.remove('hidden');
                return;
            }

            try {
                const response = await apiRequest('/auth/forgot-password', {
                    method: 'POST',
                    auth: false,
                    body: {
                        username: document.getElementById('forgot-username').value.trim(),
                        email: document.getElementById('forgot-email').value.trim(),
                        new_password: forgotNewPassword,
                        confirm_password: document.getElementById('forgot-confirm-password').value
                    }
                });

                closeOverlay(forgotPasswordOverlay);
                forgotPasswordForm.reset();
                loginForm.reset();
                switchAuthOverlay(loginOverlay);
                alert('Đặt lại mật khẩu thành công. Hãy đăng nhập lại với mật khẩu mới.');
            } catch (error) {
                forgotPasswordError.textContent = error.message;
                forgotPasswordError.classList.remove('hidden');
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

            if (!isStrongPassword(newPassword)) {
                passError.textContent = PASSWORD_RULE_MESSAGE;
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
                hinh_anh_url: document.getElementById('product-image-url').value.trim(),
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

        tabBtns.forEach(button => {
            button.addEventListener('click', () => {
                const target = button.dataset.tab;
                tabBtns.forEach(item => item.classList.toggle('active', item === button));
                tabContents.forEach(content => content.classList.toggle('active', content.id === target));
            });
        });

        productContainer.addEventListener('click', event => {
            const favoriteButton = event.target.closest('[data-favorite-toggle]');
            if (favoriteButton) {
                event.preventDefault();
                toggleWishlistProduct(favoriteButton.dataset.productId);
                return;
            }

            const button = event.target.closest('.add-to-cart-btn');
            if (!button) {
                return;
            }

            openCartConfigurator(button.dataset.productId);
        });

        wishlistGrid.addEventListener('click', event => {
            const moveButton = event.target.closest('[data-wishlist-move]');
            if (moveButton) {
                event.preventDefault();
                openCartConfigurator(moveButton.dataset.productId, { removeFromWishlist: true });
                return;
            }

            const removeButton = event.target.closest('[data-wishlist-remove]');
            if (removeButton) {
                event.preventDefault();
                removeFromWishlist(removeButton.dataset.productId);
            }
        });

        cartItemsContainer.addEventListener('click', event => {
            const actionButton = event.target.closest('[data-cart-action]');
            if (!actionButton) {
                return;
            }

            const action = actionButton.dataset.cartAction;
            const lineId = actionButton.dataset.lineId;
            if (!lineId) {
                return;
            }

            if (action === 'remove') {
                removeCartLine(lineId);
                return;
            }

            if (action === 'decrease') {
                updateCartLineQuantity(lineId, -1);
                return;
            }

            if (action === 'increase') {
                updateCartLineQuantity(lineId, 1);
            }
        });

        cartItemsContainer.addEventListener('change', event => {
            const checkbox = event.target.closest('[data-cart-select]');
            if (checkbox) {
                toggleCartLineSelection(checkbox.dataset.lineId, checkbox.checked);
                return;
            }

            const quantityInput = event.target.closest('[data-cart-quantity-input]');
            if (quantityInput) {
                setCartLineQuantity(quantityInput.dataset.lineId, quantityInput.value);
                return;
            }

            const sizeSelect = event.target.closest('[data-cart-size-select]');
            if (sizeSelect) {
                updateCartLineSize(sizeSelect.dataset.lineId, sizeSelect.value);
            }
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
            const products = await apiRequest('/products', { auth: false });
            allProducts = products.map(enrichProduct);
            renderCatalog();
            renderAdminProductList();
            if (isAdmin()) {
                await renderUserList();
            } else {
                userListBody.innerHTML = '';
            }
        } catch (error) {
            productContainer.innerHTML = `<p class="error-text">${escapeHtml(error.message)}</p>`;
        }
    }

    function renderCatalog() {
        const baseProducts = getBaseProducts();
        const filteredProducts = getFilteredProducts(baseProducts);
        renderProducts(filteredProducts);
        renderCatalogHeader(filteredProducts);
        renderCollectionView(baseProducts, filteredProducts);
        renderActiveFilters();
        renderMegaMenu();
        renderCartView();
        syncMainView();
        syncNavState();
        repairRenderedContent();
    }

    function renderCatalogHeader(filteredProducts) {
        const currentItem = getCurrentMenuItem();
        const currentHeading = currentBrand
            ? `${currentBrand} chính hãng`
            : currentItem
                ? `${currentItem.label} · ${currentItem.sport}`
                : currentCategory !== 'all'
                    ? currentCategory
                    : 'Toàn bộ sản phẩm';

        const currentDescription = currentBrand
            ? `Hiển thị các sản phẩm thuộc thương hiệu ${currentBrand}, bao gồm giày, bóng, vợt và phụ kiện liên quan.`
            : currentItem
                ? `Lọc nhanh nhóm ${currentItem.label.toLowerCase()} trong danh mục ${currentItem.sport.toLowerCase()} để khách hàng chọn đúng loại sản phẩm cần mua.`
                : currentCategory !== 'all'
                    ? `Khám phá đầy đủ sản phẩm thuộc danh mục ${currentCategory.toLowerCase()}, từ mặt hàng chủ lực đến phụ kiện đi kèm.`
                    : 'Khám phá đầy đủ giày, bóng, vợt, trang phục và phụ kiện thể thao theo đúng nhu cầu của khách hàng.';

        catalogTitle.textContent = currentHeading;
        catalogDescription.textContent = currentDescription;
        catalogCount.textContent = `${filteredProducts.length} sản phẩm`;
        clearFiltersButton.classList.toggle('hidden', !hasActiveFilters());
    }

    function renderActiveFilters() {
        const chips = [];
        const currentItem = getCurrentMenuItem();

        if (currentCategory !== 'all') {
            chips.push(renderFilterChip('Danh mục', currentCategory, 'category'));
        }

        if (currentItem) {
            chips.push(renderFilterChip('Nhóm', currentItem.label, 'item'));
        }

        if (currentBrand) {
            chips.push(renderFilterChip('Thương hiệu', currentBrand, 'brand'));
        }

        if (currentQuery) {
            chips.push(renderFilterChip('Từ khóa', currentQuery, 'query'));
        }

        activeFilters.classList.toggle('hidden', chips.length === 0);
        activeFilters.innerHTML = chips.join('');
    }

    function renderFilterChip(label, value, action) {
        return `
            <span class="filter-chip">
                <span class="filter-chip-label">${escapeHtml(label)}:</span>
                <span>${escapeHtml(value)}</span>
                <button type="button" data-clear="${escapeHtml(action)}" aria-label="Xóa bộ lọc">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </span>
        `;
    }

    function renderMegaMenu() {
        renderMegaPanel('sports');
        renderMegaPanel('apparel');
        renderMegaPanel('accessories');
        renderBrandPanel();
        syncMegaTabState();
        megaMenuSummary.textContent = getMegaMenuSummary();
    }

    function renderMegaPanel(panelName) {
        const sections = SPORT_SECTIONS.map(section => {
            const mappedItems = section.items
                .filter(item => item.panels.includes(panelName))
                .map(item => {
                    const fullItem = { ...item, sport: section.sport };
                    return { ...fullItem, count: countProductsForMenuItem(fullItem) };
                });
            const items = panelName === 'accessories'
                ? mappedItems
                : mappedItems.filter(item => item.count > 0);

            if (!items.length) {
                return '';
            }

            const itemLinks = items.map(item => `
                <li>
                    <a
                        href="#"
                        class="mega-link ${item.count === 0 ? 'disabled' : ''} ${currentMenuItemId === item.id ? 'active' : ''}"
                        ${item.count > 0 ? `data-filter-type="item" data-item-id="${item.id}"` : ''}
                    >
                        <span>${escapeHtml(item.label)}</span>
                        <strong>${item.count > 0 ? item.count : '0'}</strong>
                    </a>
                </li>
            `).join('');

            const categoryCount = countProductsForCategory(section.sport);
            return `
                <article class="mega-section-card">
                    <div class="mega-section-header">
                        <div class="mega-section-title">
                            <i class="fa-solid ${section.icon}"></i>
                            <h3>${escapeHtml(section.sport)}</h3>
                        </div>
                        <a
                            href="#"
                            class="mega-section-view ${currentCategory === section.sport && !currentMenuItemId && !currentBrand ? 'active' : ''}"
                            data-filter-type="category"
                            data-category="${escapeHtml(section.sport)}"
                        >
                            Xem tất cả <strong>${categoryCount}</strong>
                        </a>
                    </div>
                    <ul class="mega-link-list">
                        ${itemLinks}
                    </ul>
                </article>
            `;
        }).filter(Boolean);

        megaPanels[panelName].innerHTML = sections.length
            ? sections.join('')
            : '<p class="mega-empty">Chưa có nhóm sản phẩm phù hợp.</p>';
    }

    function renderBrandPanel() {
        const brandMap = new Map();

        allProducts.forEach(product => {
            const brand = String(product.thuong_hieu || '').trim();
            if (!brand) {
                return;
            }

            if (!brandMap.has(brand)) {
                brandMap.set(brand, { count: 0, sports: new Set() });
            }

            const current = brandMap.get(brand);
            current.count += 1;
            current.sports.add(getCanonicalSportFromProduct(product));
        });

        const brandCards = Array.from(brandMap.entries())
            .sort((left, right) => {
                if (right[1].count !== left[1].count) {
                    return right[1].count - left[1].count;
                }
                return left[0].localeCompare(right[0], 'vi');
            })
            .map(([brand, meta]) => `
                <a
                    href="#"
                    class="brand-card ${currentBrand === brand ? 'active' : ''}"
                    data-filter-type="brand"
                    data-brand="${escapeHtml(brand)}"
                >
                    <span class="brand-card-name">${escapeHtml(brand)}</span>
                    <span class="brand-card-sports">${escapeHtml(Array.from(meta.sports).join(' · '))}</span>
                    <strong>${meta.count} sản phẩm</strong>
                </a>
            `)
            .join('');

        megaPanels.brands.innerHTML = brandCards || '<p class="mega-empty">Chưa có thương hiệu để hiển thị.</p>';
    }

    function renderProducts(products) {
        if (!products.length) {
            productContainer.innerHTML = '<p class="loading-text">Không có sản phẩm phù hợp với bộ lọc hiện tại.</p>';
            return;
        }

        productContainer.innerHTML = products.map(product => {
            const badge = product.ton_kho <= 3
                ? '<span class="badge danger">Sắp hết</span>'
                : (product.ton_kho <= 10 ? '<span class="badge warning">Bán chạy</span>' : '');

            return `
                <article class="product-card">
                    <div class="product-img">
                        ${badge}
                        <img src="${escapeHtml(getProductImageUrl(product))}" alt="${escapeHtml(product.ten_san_pham)}" loading="lazy">
                    </div>
                    <div class="product-info">
                        <p class="product-category">${escapeHtml(product.danh_muc || '')}</p>
                        <h3 class="product-name">${escapeHtml(product.ten_san_pham || '')}</h3>
                        <p class="product-subcategory">${escapeHtml(getProductGroupLabel(product))}</p>
                        <div class="product-meta">
                            <span>${escapeHtml(product.thuong_hieu || 'Không rõ')}</span>
                            <span>${escapeHtml(product.size || '--')}</span>
                        </div>
                        <p class="product-price">${formatCurrency(product.gia_ban)}</p>
                        <p class="product-stock">Tồn kho: ${product.ton_kho ?? 0}</p>
                        <button class="add-to-cart-btn" data-product-id="${product.id}">Thêm vào giỏ</button>
                    </div>
                </article>
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
                    <button class="edit-btn" type="button" data-action="edit" data-product-id="${product.id}"><i class="fa-solid fa-pen"></i></button>
                    <button class="delete-btn" type="button" data-action="delete" data-product-id="${product.id}"><i class="fa-solid fa-trash"></i></button>
                </td>
            </tr>
        `).join('');
        repairTextNodes(productListBody);
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
            repairTextNodes(userListBody);
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
        repairRenderedContent();
    }

    function getFilteredProducts() {
        return allProducts.filter(product => {
            const matchesCategory = currentCategory === 'all'
                || normalizeText(getCanonicalSportFromProduct(product)) === normalizeText(currentCategory);
            const matchesMenuItem = !currentMenuItemId || matchesMenuItemRule(product, getCurrentMenuItem());
            const matchesBrand = !currentBrand || normalizeText(product.thuong_hieu) === normalizeText(currentBrand);

            const haystack = normalizeText([
                product.ten_san_pham,
                product.danh_muc,
                product.thuong_hieu,
                product.sku
            ].filter(Boolean).join(' '));
            const matchesQuery = !currentQuery || haystack.includes(normalizeText(currentQuery));
            return matchesCategory && matchesMenuItem && matchesBrand && matchesQuery;
        });
    }

    function applyCategoryFilter(category) {
        currentCategory = category || 'all';
        currentMenuItemId = '';
        currentBrand = '';
        renderCatalog();
    }

    function applyMenuItemFilter(itemId) {
        const item = findMenuItemById(itemId);
        if (!item) {
            return;
        }

        currentCategory = item.sport;
        currentMenuItemId = itemId;
        currentBrand = '';
        renderCatalog();
    }

    function applyBrandFilter(brand) {
        currentBrand = brand || '';
        currentMenuItemId = '';
        currentCategory = 'all';
        renderCatalog();
    }

    function resetCatalogState(options = {}) {
        const { clearQuery = false } = options;
        currentCategory = 'all';
        currentMenuItemId = '';
        currentBrand = '';
        if (clearQuery) {
            currentQuery = '';
            searchInput.value = '';
        }
        renderCatalog();
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
        document.getElementById('product-image-url').value = product.hinh_anh_url || '';
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

    function toggleMegaMenu() {
        const shouldOpen = megaMenu.classList.contains('hidden');
        if (shouldOpen) {
            megaMenu.classList.remove('hidden');
            megaMenu.setAttribute('aria-hidden', 'false');
        } else {
            closeMegaMenu();
        }
        syncNavState();
    }

    function closeMegaMenu() {
        megaMenu.classList.add('hidden');
        megaMenu.setAttribute('aria-hidden', 'true');
        syncNavState();
    }

    function syncMegaTabState() {
        megaTabs.forEach(tab => {
            tab.classList.toggle('active', tab.dataset.tab === activeMegaTab);
        });

        Object.entries(megaPanels).forEach(([panelName, panel]) => {
            panel.classList.toggle('active', panelName === activeMegaTab);
        });
    }

    function syncNavState() {
        const isMegaMenuOpen = !megaMenu.classList.contains('hidden');
        catalogTrigger.classList.toggle('active', isMegaMenuOpen || Boolean(currentMenuItemId) || Boolean(currentBrand) || currentCategory === 'all');

        navLinks.forEach(link => {
            const category = link.dataset.category;
            const active = currentCategory === category;
            link.classList.toggle('active', active);
        });
    }

    function clearSession() {
        token = '';
        currentUser = null;
        localStorage.removeItem(TOKEN_KEY);
        localStorage.removeItem(USER_KEY);
        userDropdown.classList.add('hidden');
    }

    function applyLoginSession(response) {
        token = response?.access_token || '';
        currentUser = response?.user || null;
        localStorage.setItem(TOKEN_KEY, token);
        localStorage.setItem(USER_KEY, JSON.stringify(currentUser));
    }

    function switchAuthOverlay(targetOverlay) {
        [loginOverlay, registerOverlay, forgotPasswordOverlay].forEach(overlay => {
            if (overlay !== targetOverlay) {
                closeOverlay(overlay);
            }
        });
        openOverlay(targetOverlay);
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

    function findMenuItemById(itemId) {
        for (const section of SPORT_SECTIONS) {
            for (const item of section.items) {
                if (item.id === itemId) {
                    return { ...item, sport: section.sport, icon: section.icon };
                }
            }
        }
        return null;
    }

    function getCurrentMenuItem() {
        return currentMenuItemId ? findMenuItemById(currentMenuItemId) : null;
    }

    function countProductsForCategory(category) {
        return allProducts.filter(product => normalizeText(getCanonicalSportFromProduct(product)) === normalizeText(category)).length;
    }

    function countProductsForMenuItem(item) {
        return allProducts.filter(product => matchesMenuItemRule(product, item)).length;
    }

    function matchesMenuItemRule(product, item) {
        if (!item) {
            return true;
        }

        if (normalizeText(getCanonicalSportFromProduct(product)) !== normalizeText(item.sport)) {
            return false;
        }

        return getMenuItemIdsForProduct(product).includes(item.id);
    }

    function getProductGroupLabel(product) {
        const itemIds = getMenuItemIdsForProduct(product);
        for (const section of SPORT_SECTIONS) {
            for (const item of section.items) {
                if (itemIds.includes(item.id)) {
                    return item.label;
                }
            }
        }
        return getCanonicalSportFromProduct(product);
    }

    function getMegaMenuSummary() {
        const currentItem = getCurrentMenuItem();
        if (currentBrand) {
            return `Đang xem theo thương hiệu ${currentBrand}. Chọn thương hiệu khác hoặc quay lại toàn bộ sản phẩm.`;
        }
        if (currentItem) {
            return `Đang lọc nhóm ${currentItem.label.toLowerCase()} trong danh mục ${currentItem.sport.toLowerCase()}.`;
        }
        if (currentCategory !== 'all') {
            return `Đang xem toàn bộ sản phẩm thuộc danh mục ${currentCategory.toLowerCase()}.`;
        }
        return 'Chọn nhanh theo môn thể thao, trang phục, phụ kiện hoặc thương hiệu.';
    }

    function getCurrentCollection() {
        return COLLECTION_SECTIONS.find(collection => collection.id === currentCollectionId) || null;
    }

    function getBaseProducts() {
        return currentCollectionId ? buildCollectionProducts(currentCollectionId) : allProducts;
    }

    function buildCollectionProducts(collectionId) {
        const curatedSkus = COLLECTION_PRODUCT_MAP[collectionId] || [];
        if (!curatedSkus.length) {
            return [...allProducts];
        }

        const skuOrder = new Map(curatedSkus.map((sku, index) => [sku, index]));
        return allProducts
            .filter(product => skuOrder.has(String(product.sku || '').trim().toUpperCase()))
            .sort((left, right) => skuOrder.get(String(left.sku || '').trim().toUpperCase()) - skuOrder.get(String(right.sku || '').trim().toUpperCase()));
    }

    function isHotCollectionProduct(product) {
        const hotBrands = ['nike', 'adidas', 'yonex', 'mizuno', 'puma'];
        return hotBrands.includes(normalizeText(product.thuong_hieu)) || (product.ton_kho ?? 0) <= 10;
    }

    function isSeagamesCollectionProduct(product) {
        const group = normalizeText(getProductGroupLabel(product));
        return group.includes('quan ao')
            || group.includes('giay')
            || group.includes('tat')
            || group.includes('balo')
            || group.includes('gang tay')
            || group.includes('phu kien')
            || group.includes('bao ve');
    }

    function normalizeSizeValue(size) {
        const normalized = String(size || '').trim();
        if (!normalized || normalized === '--' || normalizeText(normalized) === 'khong ro') {
            return '';
        }
        return normalized;
    }

    function getUniqueValues(values) {
        return Array.from(new Set(values.filter(Boolean)))
            .sort((left, right) => left.localeCompare(right, 'vi', { numeric: true }));
    }

    function hasOption(selectElement, value) {
        return Array.from(selectElement.options).some(option => option.value === value);
    }

    function getPriceRangeLabel(range) {
        const labels = {
            'under-500': 'Dưới 500.000đ',
            '500-1000': '500.000đ - 1.000.000đ',
            '1000-1500': '1.000.000đ - 1.500.000đ',
            'over-1500': 'Trên 1.500.000đ'
        };
        return labels[range] || 'Tất cả mức giá';
    }

    function matchesPriceRange(price, range) {
        const value = Number(price || 0);
        if (range === 'under-500') {
            return value < 500000;
        }
        if (range === '500-1000') {
            return value >= 500000 && value <= 1000000;
        }
        if (range === '1000-1500') {
            return value > 1000000 && value <= 1500000;
        }
        if (range === 'over-1500') {
            return value > 1500000;
        }
        return true;
    }

    function sortProducts(products) {
        if (currentSortOption === 'price-asc') {
            return [...products].sort((left, right) => (left.gia_ban ?? 0) - (right.gia_ban ?? 0));
        }
        if (currentSortOption === 'price-desc') {
            return [...products].sort((left, right) => (right.gia_ban ?? 0) - (left.gia_ban ?? 0));
        }
        if (currentSortOption === 'stock-desc') {
            return [...products].sort((left, right) => (right.ton_kho ?? 0) - (left.ton_kho ?? 0));
        }
        if (currentSortOption === 'name-asc') {
            return [...products].sort((left, right) => String(left.ten_san_pham || '').localeCompare(String(right.ten_san_pham || ''), 'vi'));
        }
        return products;
    }

    function renderCatalogHeader(filteredProducts) {
        if (currentCollectionId) {
            catalogToolbar.classList.add('hidden');
            clearFiltersButton.classList.add('hidden');
            return;
        }

        catalogToolbar.classList.remove('hidden');
        const currentItem = getCurrentMenuItem();
        const currentHeading = currentBrand
            ? `${currentBrand} chính hãng`
            : currentItem
                ? `${currentItem.label} · ${currentItem.sport}`
                : currentCategory !== 'all'
                    ? currentCategory
                    : 'Toàn bộ sản phẩm';

        const currentDescription = currentBrand
            ? `Hiển thị các sản phẩm thuộc thương hiệu ${currentBrand}, bao gồm giày, bóng, vợt và phụ kiện liên quan.`
            : currentItem
                ? `Lọc nhanh nhóm ${currentItem.label.toLowerCase()} trong danh mục ${currentItem.sport.toLowerCase()} để khách hàng chọn đúng loại sản phẩm cần mua.`
                : currentCategory !== 'all'
                    ? `Khám phá đầy đủ sản phẩm thuộc danh mục ${currentCategory.toLowerCase()}, từ mặt hàng chủ lực đến phụ kiện đi kèm.`
                    : 'Khám phá đầy đủ giày, bóng, vợt, trang phục và phụ kiện thể thao theo đúng nhu cầu của khách hàng.';

        catalogTitle.textContent = currentHeading;
        catalogDescription.textContent = currentDescription;
        catalogCount.textContent = `${filteredProducts.length} sản phẩm`;
        clearFiltersButton.classList.toggle('hidden', !hasActiveFilters());
    }

    function renderCollectionView(baseProducts, filteredProducts) {
        const currentCollection = getCurrentCollection();
        collectionView.classList.toggle('hidden', !currentCollection);

        if (!currentCollection) {
            return;
        }

        collectionBreadcrumb.textContent = currentCollection.breadcrumb;
        collectionEyebrow.textContent = currentCollection.eyebrow;
        collectionTitle.textContent = currentCollection.label;
        collectionDescription.textContent = currentCollection.description;
        collectionCount.textContent = `${filteredProducts.length} sản phẩm`;

        collectionShortcuts.innerHTML = COLLECTION_SECTIONS.map(collection => `
            <button
                type="button"
                class="collection-shortcut ${collection.id === currentCollectionId ? 'active' : ''}"
                data-collection-shortcut="${collection.id}"
            >
                <i class="fa-solid ${collection.icon}"></i>
                <span>${escapeHtml(collection.label)}</span>
            </button>
        `).join('');

        collectionShortcuts.querySelectorAll('[data-collection-shortcut]').forEach(button => {
            button.addEventListener('click', () => applyCollectionFilter(button.dataset.collectionShortcut));
        });

        fillSelectOptions(
            typeFilter,
            'all',
            'Tất cả loại sản phẩm',
            getUniqueValues(baseProducts.map(product => getProductGroupLabel(product)))
        );
        fillSelectOptions(
            brandFilter,
            'all',
            'Tất cả thương hiệu',
            getUniqueValues(baseProducts.map(product => product.thuong_hieu))
        );
        fillSelectOptions(
            sizeFilter,
            'all',
            'Tất cả size',
            getUniqueValues(baseProducts.map(product => normalizeSizeValue(product.size)))
        );

        priceFilter.value = currentPriceRange;
        typeFilter.value = hasOption(typeFilter, currentTypeFilter) ? currentTypeFilter : 'all';
        brandFilter.value = hasOption(brandFilter, currentBrand) ? currentBrand : 'all';
        sizeFilter.value = hasOption(sizeFilter, currentSizeFilter) ? currentSizeFilter : 'all';
        sortFilter.value = currentSortOption;
    }

    function fillSelectOptions(selectElement, allValue, allLabel, values) {
        const options = [`<option value="${allValue}">${escapeHtml(allLabel)}</option>`];
        values.forEach(value => {
            options.push(`<option value="${escapeHtml(value)}">${escapeHtml(value)}</option>`);
        });
        selectElement.innerHTML = options.join('');
    }

    function renderActiveFilters() {
        const chips = [];
        const currentItem = getCurrentMenuItem();
        const currentCollection = getCurrentCollection();

        if (currentCollection) {
            chips.push(renderFilterChip('Bộ sưu tập', currentCollection.label, 'collection'));
        }

        if (currentCategory !== 'all') {
            chips.push(renderFilterChip('Danh mục', currentCategory, 'category'));
        }

        if (currentItem) {
            chips.push(renderFilterChip('Nhóm', currentItem.label, 'item'));
        }

        if (currentBrand) {
            chips.push(renderFilterChip('Thương hiệu', currentBrand, 'brand'));
        }

        if (currentPriceRange !== 'all') {
            chips.push(renderFilterChip('Giá', getPriceRangeLabel(currentPriceRange), 'price'));
        }

        if (currentTypeFilter !== 'all') {
            chips.push(renderFilterChip('Loại sản phẩm', currentTypeFilter, 'type'));
        }

        if (currentSizeFilter !== 'all') {
            chips.push(renderFilterChip('Size', currentSizeFilter, 'size'));
        }

        if (currentQuery) {
            chips.push(renderFilterChip('Từ khóa', currentQuery, 'query'));
        }

        activeFilters.classList.toggle('hidden', chips.length === 0);
        activeFilters.innerHTML = chips.join('');
    }

    function getFilteredProducts(baseProducts = getBaseProducts()) {
        const filteredProducts = baseProducts.filter(product => {
            const matchesCategory = currentCollectionId
                ? true
                : currentCategory === 'all' || normalizeText(getCanonicalSportFromProduct(product)) === normalizeText(currentCategory);
            const matchesMenuItem = currentCollectionId
                ? true
                : !currentMenuItemId || matchesMenuItemRule(product, getCurrentMenuItem());
            const matchesBrand = !currentBrand || normalizeText(product.thuong_hieu) === normalizeText(currentBrand);
            const matchesType = currentTypeFilter === 'all' || normalizeText(getProductGroupLabel(product)) === normalizeText(currentTypeFilter);
            const matchesSize = currentSizeFilter === 'all' || normalizeText(normalizeSizeValue(product.size)) === normalizeText(currentSizeFilter);
            const matchesPrice = matchesPriceRange(product.gia_ban, currentPriceRange);

            const haystack = normalizeText([
                product.ten_san_pham,
                product.danh_muc,
                product.thuong_hieu,
                product.sku,
                getProductGroupLabel(product)
            ].filter(Boolean).join(' '));
            const matchesQuery = !currentQuery || haystack.includes(normalizeText(currentQuery));

            return matchesCategory && matchesMenuItem && matchesBrand && matchesType && matchesSize && matchesPrice && matchesQuery;
        });

        return sortProducts(filteredProducts);
    }

    function applyCollectionFilter(collectionId) {
        currentCollectionId = collectionId || '';
        currentCategory = 'all';
        currentMenuItemId = '';
        currentBrand = '';
        currentPriceRange = 'all';
        currentTypeFilter = 'all';
        currentSizeFilter = 'all';
        currentSortOption = 'featured';
        renderCatalog();
    }

    function applyCategoryFilter(category) {
        currentCollectionId = '';
        currentCategory = category || 'all';
        currentMenuItemId = '';
        currentBrand = '';
        currentPriceRange = 'all';
        currentTypeFilter = 'all';
        currentSizeFilter = 'all';
        currentSortOption = 'featured';
        renderCatalog();
    }

    function applyMenuItemFilter(itemId) {
        const item = findMenuItemById(itemId);
        if (!item) {
            return;
        }

        currentCollectionId = '';
        currentCategory = item.sport;
        currentMenuItemId = itemId;
        currentBrand = '';
        currentPriceRange = 'all';
        currentTypeFilter = 'all';
        currentSizeFilter = 'all';
        currentSortOption = 'featured';
        renderCatalog();
    }

    function applyBrandFilter(brand) {
        currentCollectionId = '';
        currentBrand = brand || '';
        currentMenuItemId = '';
        currentCategory = 'all';
        currentPriceRange = 'all';
        currentTypeFilter = 'all';
        currentSizeFilter = 'all';
        currentSortOption = 'featured';
        renderCatalog();
    }

    function resetCatalogState(options = {}) {
        const { clearQuery = false } = options;
        currentCollectionId = '';
        currentCategory = 'all';
        currentMenuItemId = '';
        currentBrand = '';
        currentPriceRange = 'all';
        currentTypeFilter = 'all';
        currentSizeFilter = 'all';
        currentSortOption = 'featured';
        if (clearQuery) {
            currentQuery = '';
            searchInput.value = '';
        }
        renderCatalog();
    }

    function syncNavState() {
        const isMegaMenuOpen = !megaMenu.classList.contains('hidden');
        catalogTrigger.classList.toggle('active', !currentCollectionId && (isMegaMenuOpen || Boolean(currentMenuItemId) || Boolean(currentBrand) || currentCategory === 'all'));

        navCollectionLinks.forEach(link => {
            link.classList.toggle('active', link.dataset.collection === currentCollectionId);
        });
    }

    function getMegaMenuSummary() {
        const currentItem = getCurrentMenuItem();
        if (currentBrand && !currentCollectionId) {
            return `Đang xem theo thương hiệu ${currentBrand}. Chọn thương hiệu khác hoặc quay lại toàn bộ sản phẩm.`;
        }
        if (currentItem && !currentCollectionId) {
            return `Đang lọc nhóm ${currentItem.label.toLowerCase()} trong danh mục ${currentItem.sport.toLowerCase()}.`;
        }
        if (currentCategory !== 'all' && !currentCollectionId) {
            return `Đang xem toàn bộ sản phẩm thuộc danh mục ${currentCategory.toLowerCase()}.`;
        }
        return 'Chọn nhanh theo môn thể thao, trang phục, phụ kiện hoặc thương hiệu.';
    }

    function hasActiveFilters() {
        return Boolean(currentCollectionId)
            || currentCategory !== 'all'
            || Boolean(currentMenuItemId)
            || Boolean(currentBrand)
            || currentPriceRange !== 'all'
            || currentTypeFilter !== 'all'
            || currentSizeFilter !== 'all'
            || Boolean(currentQuery);
    }

    async function loadProducts() {
        productContainer.innerHTML = '<p class="loading-text">Đang tải sản phẩm...</p>';

        try {
            const products = await apiRequest('/products', { auth: false });
            allProducts = products.map(enrichProduct);
            renderCatalog();
            renderAdminProductList();
            if (isAdmin()) {
                await renderUserList();
            } else {
                userListBody.innerHTML = '';
            }
        } catch (error) {
            productContainer.innerHTML = `<p class="error-text">${escapeHtml(error.message)}</p>`;
        }
    }

    function renderProducts(products) {
        if (!products.length) {
            productContainer.innerHTML = '<p class="loading-text">Không có sản phẩm phù hợp với bộ lọc hiện tại.</p>';
            return;
        }

        productContainer.innerHTML = products.map(product => {
            const badge = product.ton_kho <= 3
                ? '<span class="badge danger">Sắp hết</span>'
                : (product.ton_kho <= 10 ? '<span class="badge warning">Bán chạy</span>' : '');

            return `
                <article class="product-card">
                    <div class="product-img">
                        ${badge}
                        <img src="${escapeHtml(getProductImageUrl(product))}" alt="${escapeHtml(product.ten_san_pham)}" loading="lazy">
                    </div>
                    <div class="product-info">
                        <p class="product-category">${escapeHtml(product.danh_muc || '')}</p>
                        <h3 class="product-name">${escapeHtml(product.ten_san_pham || '')}</h3>
                        <p class="product-subcategory">${escapeHtml(getProductGroupLabel(product))}</p>
                        <div class="product-meta">
                            <span>${escapeHtml(product.thuong_hieu || 'Không rõ')}</span>
                            <span>${escapeHtml(normalizeSizeValue(product.size) || '--')}</span>
                        </div>
                        <p class="product-price">${formatCurrency(product.gia_ban)}</p>
                        <p class="product-stock">Tồn kho: ${product.ton_kho ?? 0}</p>
                        <button class="add-to-cart-btn" data-product-id="${product.id}">Thêm vào giỏ</button>
                    </div>
                </article>
            `;
        }).join('');
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
        repairRenderedContent();
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
            .toLowerCase()
            .trim();
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

    function getProductImageUrl(product) {
        const explicitUrl = String(product.hinh_anh_url || '').trim();
        if (explicitUrl) {
            return explicitUrl;
        }
        return buildProductPoster(product);
    }

    function buildProductPoster(product) {
        const [startColor, endColor] = getCategoryPalette(product.danh_muc);
        const brand = escapeSvgText(product.thuong_hieu || 'Flare Fitness');
        const category = escapeSvgText(product.danh_muc || 'Thể thao');
        const name = escapeSvgText((product.ten_san_pham || 'Sản phẩm').slice(0, 56));
        const sku = escapeSvgText(product.sku || '');
        const price = escapeSvgText(formatCurrency(product.gia_ban));
        const svg = `
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 800">
                <defs>
                    <linearGradient id="g" x1="0" x2="1" y1="0" y2="1">
                        <stop offset="0%" stop-color="${startColor}"/>
                        <stop offset="100%" stop-color="${endColor}"/>
                    </linearGradient>
                </defs>
                <rect width="800" height="800" fill="url(#g)"/>
                <circle cx="660" cy="140" r="110" fill="rgba(255,255,255,0.12)"/>
                <circle cx="120" cy="680" r="150" fill="rgba(255,255,255,0.08)"/>
                <rect x="52" y="52" width="696" height="696" rx="36" fill="rgba(255,255,255,0.08)" stroke="rgba(255,255,255,0.18)"/>
                <text x="80" y="122" fill="#F9FAFB" font-family="Segoe UI, Arial, sans-serif" font-size="30" font-weight="700">${brand}</text>
                <text x="80" y="168" fill="#DBEAFE" font-family="Segoe UI, Arial, sans-serif" font-size="24" font-weight="600">${category}</text>
                <foreignObject x="80" y="220" width="640" height="270">
                    <div xmlns="http://www.w3.org/1999/xhtml" style="font-family:Segoe UI,Arial,sans-serif;font-size:44px;line-height:1.15;color:#FFFFFF;font-weight:800;">
                        ${name}
                    </div>
                </foreignObject>
                <text x="80" y="636" fill="#E5E7EB" font-family="Segoe UI, Arial, sans-serif" font-size="24" font-weight="600">${sku}</text>
                <text x="80" y="698" fill="#FDE68A" font-family="Segoe UI, Arial, sans-serif" font-size="42" font-weight="800">${price}</text>
            </svg>
        `;
        return `data:image/svg+xml;charset=UTF-8,${encodeURIComponent(svg)}`;
    }

    function getCategoryPalette(category) {
        const normalized = normalizeText(category);
        if (normalized.includes('bong da')) {
            return ['#0B2E59', '#1D8348'];
        }
        if (normalized.includes('bong ban')) {
            return ['#7C2D12', '#DC2626'];
        }
        if (normalized.includes('bong chuyen')) {
            return ['#0F766E', '#0EA5E9'];
        }
        if (normalized.includes('bong ro')) {
            return ['#7C2D12', '#EA580C'];
        }
        if (normalized.includes('cau long')) {
            return ['#1D4ED8', '#4F46E5'];
        }
        return ['#1E3A8A', '#BF3828'];
    }

    function escapeSvgText(value) {
        return String(value ?? '')
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;');
    }

    function enrichProduct(product) {
        const sku = String(product.sku || '').trim().toUpperCase();
        return {
            ...product,
            ten_san_pham: normalizeProductName(product.ten_san_pham, sku),
            danh_muc: getCanonicalSportFromSku(product.sku, product.danh_muc),
            thuong_hieu: normalizeBrand(product.thuong_hieu, sku),
            size: normalizeProductSize(product.size, sku),
            mau: normalizeProductColor(product.mau, sku),
            ghi_chu: sanitizeProductText(product.ghi_chu),
            mo_ta_ngan: sanitizeProductText(product.mo_ta_ngan),
            trang_thai: sanitizeProductText(product.trang_thai)
        };
    }

    function normalizeProductName(value, sku = '') {
        const overrides = {
            'VB-001': 'Bóng chuyền hơi Động Lực',
            'BB-017': 'Bảng rổ mini Spalding Slam Jam Over-The-Door Mini Hoop',
            'TT-001': 'Vợt bóng bàn 7 lớp gỗ'
        };
        if (overrides[sku]) {
            return overrides[sku];
        }

        const cleaned = sanitizeProductText(value);
        const skuPrefix = getSkuPrefix(sku);
        const skuNumber = getSkuNumber(sku);

        if (skuPrefix === 'FB') {
            const tail = extractProductTail(cleaned, ['Nike', 'adidas', 'Puma', 'PUMA', 'Mizuno', 'Select']);
            if (skuNumber === 1) return 'Giày bóng đá cỏ nhân tạo Nike';
            if (skuNumber === 3) return 'Áo thi đấu CLB Manchester City 2024';
            if (skuNumber >= 7 && skuNumber <= 15) return `Giày bóng đá ${tail}`;
            if (skuNumber === 16 || skuNumber === 27) return `Bóng đá ${tail}`;
            if (skuNumber === 17 || skuNumber === 18) return `Áo tập bóng đá ${tail}`;
            if (skuNumber === 19) return `Áo bóng đá ${tail}`;
            if (skuNumber === 20) return `Áo khoác bóng đá ${tail}`;
            if (skuNumber === 21 || skuNumber === 22) return `Quần tập bóng đá ${tail}`;
            if (skuNumber === 23) return `Balo bóng đá ${tail}`;
            if (skuNumber === 24) return `Túi trống bóng đá ${tail}`;
            if (skuNumber === 25) return `Bịt ống đồng bóng đá ${tail}`;
            if (skuNumber === 26) return `Găng tay thủ môn ${tail}`;
            if (skuNumber === 28 || skuNumber === 29) return `Tất bóng đá ${tail}`;
            if (skuNumber === 30 || skuNumber === 31) return `${tail}`;
        }

        if (skuPrefix === 'VB') {
            const tail = extractProductTail(cleaned, ['Mikasa', 'Molten', 'Wilson', 'Tachikara', 'adidas', 'Mizuno', 'ASICS', 'Nike', 'Puma', 'McDavid']);
            if (skuNumber >= 2 && skuNumber <= 5) return `Bóng chuyền ${tail}`;
            if (skuNumber === 6 || skuNumber === 8 || skuNumber === 9) return `Bóng chuyền bãi biển ${tail}`;
            if (skuNumber === 7) return `Bóng chuyền ${tail}`;
            if (skuNumber >= 10 && skuNumber <= 14) return `Giày bóng chuyền ${tail}`;
            if (skuNumber === 15 || skuNumber === 16 || skuNumber === 19) return `Bảo vệ gối bóng chuyền ${tail}`;
            if (skuNumber === 17) return 'Áo thi đấu bóng chuyền adidas Tabela 23 Jersey';
            if (skuNumber === 18) return 'Áo bóng chuyền Puma teamLIGA Jersey';
            if (skuNumber === 20) return 'Bóng chuyền mini Mikasa VQ2000';
            if (skuNumber === 21) return `Giày bóng chuyền ${tail}`;
        }

        if (skuPrefix === 'BB') {
            const tail = extractProductTail(cleaned, ['Spalding', 'Molten', 'Wilson', 'Nike', 'adidas', 'PUMA', 'Under Armour', 'Jordan', 'McDavid']);
            if ((skuNumber >= 2 && skuNumber <= 8) || skuNumber === 15 || skuNumber === 16 || skuNumber === 18 || skuNumber === 23) return `Bóng rổ ${tail}`;
            if (skuNumber >= 9 && skuNumber <= 14) return `Giày bóng rổ ${tail}`;
            if (skuNumber === 19) return `Ống tay bóng rổ ${tail}`;
            if (skuNumber === 20) return `Tất bóng rổ ${tail}`;
            if (skuNumber === 21) return `Áo bóng rổ ${tail}`;
            if (skuNumber === 22) return `Balo bóng rổ ${tail}`;
        }

        if (skuPrefix === 'TT') {
            const tail = extractProductTail(cleaned, ['Butterfly', 'DHS', '729 Focus 1', '729', 'STIGA', 'Donic', 'JOOLA', 'Nittaku', 'Xiom']);
            if ((skuNumber >= 7 && skuNumber <= 16) || skuNumber === 27) return `Vợt bóng bàn ${tail}`;
            if (skuNumber >= 17 && skuNumber <= 21) return `Mặt vợt bóng bàn ${tail}`;
            if (skuNumber >= 22 && skuNumber <= 24) return `Bóng bóng bàn ${tail}`;
            if (skuNumber === 25) return `Bộ lưới bóng bàn ${tail}`;
            if (skuNumber === 26) return `Keo dán mặt vợt ${tail}`;
        }

        if (skuPrefix === 'BM') {
            const tail = extractProductTail(cleaned, ['Yonex', 'Li-Ning', 'Victor', 'VICTOR']);
            if ((skuNumber >= 2 && skuNumber <= 9) || skuNumber === 22) return `Vợt cầu lông ${tail}`;
            if (skuNumber === 10 || skuNumber === 12 || skuNumber === 13) return `Cầu lông lông vũ ${tail}`;
            if (skuNumber === 11) return `Cầu lông nhựa ${tail}`;
            if (skuNumber >= 14 && skuNumber <= 17) return `Giày cầu lông ${tail}`;
            if (skuNumber === 18 || skuNumber === 19) return `Cước cầu lông ${tail}`;
            if (skuNumber === 20) return `Túi cầu lông ${tail}`;
            if (skuNumber === 21) return `Quấn cán cầu lông ${tail}`;
        }

        return repairQuestionMarkText(cleaned, sku, 'name');
    }

    function normalizeBrand(value, sku = '') {
        const skuOverrides = {
            'VB-001': 'Động Lực'
        };

        if (skuOverrides[sku]) {
            return skuOverrides[sku];
        }

        const cleaned = sanitizeProductText(value);
        const aliasMap = {
            'puma': 'Puma',
            'joola': 'JOOLA',
            'stiga': 'STIGA',
            'asics': 'ASICS',
            'dhs': 'DHS',
            'li-ning': 'Li-Ning',
            'li ning': 'Li-Ning',
            'under armour': 'Under Armour',
            '729-focus': '729-Focus',
            '729': '729'
        };
        return aliasMap[normalizeText(cleaned)] || cleaned;
    }

    function normalizeProductSize(value, sku = '') {
        const cleaned = sanitizeProductText(value);
        const skuPrefix = getSkuPrefix(sku);
        const skuNumber = getSkuNumber(sku);

        if (skuPrefix === 'FB') {
            if (skuNumber === 16 || skuNumber === 27) return 'Số 5';
        }

        if (skuPrefix === 'VB') {
            if (skuNumber === 1) return 'Tiêu chuẩn / Mềm';
            if ((skuNumber >= 2 && skuNumber <= 9) || skuNumber === 22) return 'Số 5';
        }

        if (skuPrefix === 'BB') {
            if ((skuNumber >= 2 && skuNumber <= 8) || skuNumber === 15 || skuNumber === 16 || skuNumber === 18 || skuNumber === 23) return 'Số 7';
        }

        if (skuPrefix === 'TT') {
            if ((skuNumber >= 7 && skuNumber <= 16) || skuNumber === 25 || skuNumber === 27 || skuNumber === 1) return 'Tiêu chuẩn';
        }

        if (skuPrefix === 'BM') {
            if (skuNumber === 10 || skuNumber === 12 || skuNumber === 13) return '12 quả';
            if (skuNumber === 11) return '6 quả';
            if (skuNumber === 20) return '6 cây';
            if (skuNumber === 21) return '3 cuộn';
        }

        return repairQuestionMarkText(cleaned, sku, 'size');
    }

    function normalizeProductColor(value, sku = '') {
        const overrides = {
            'TT-001': 'Gỗ / Đen',
            'TT-007': 'Đỏ / Đen',
            'TT-008': 'Đỏ / Đen',
            'TT-009': 'Đỏ / Đen',
            'TT-010': 'Đỏ / Đen',
            'TT-011': 'Đỏ / Đen',
            'TT-012': 'Đỏ / Đen',
            'TT-013': 'Đỏ / Đen',
            'TT-014': 'Đen / Đỏ',
            'TT-015': 'Đỏ / Đen',
            'TT-016': 'Đỏ / Đen',
            'TT-017': 'Đỏ',
            'TT-018': 'Đen',
            'TT-019': 'Đỏ',
            'TT-020': 'Đen',
            'TT-021': 'Đỏ',
            'TT-022': 'Trắng',
            'TT-023': 'Trắng',
            'TT-024': 'Trắng',
            'TT-025': 'Đen',
            'TT-026': 'Trắng',
            'TT-027': 'Gỗ tự nhiên',
            'TT-028': 'Đen / Xanh',
            'FB-001': 'Xanh / Trắng',
            'FB-003': 'Xanh dương',
            'FB-007': 'Đen / Xanh ngọc',
            'FB-008': 'Trắng / Hồng',
            'FB-009': 'Xanh lam / Trắng',
            'FB-010': 'Đỏ / Đen',
            'FB-011': 'Trắng / Xanh',
            'FB-012': 'Trắng / Đen',
            'FB-013': 'Xanh navy / Bạc',
            'FB-014': 'Vàng / Đen',
            'FB-015': 'Trắng / Đỏ',
            'FB-016': 'Trắng / Xanh',
            'FB-017': 'Đen',
            'FB-018': 'Xanh navy',
            'FB-019': 'Trắng / Đen',
            'FB-020': 'Xám / Đen',
            'FB-021': 'Đen',
            'FB-022': 'Đen',
            'FB-023': 'Đen / Trắng',
            'FB-024': 'Đen',
            'FB-025': 'Trắng / Đen',
            'FB-026': 'Đen / Đỏ',
            'FB-027': 'Trắng / Đen',
            'FB-028': 'Trắng / Đen',
            'FB-029': 'Xanh navy / Trắng',
            'FB-030': 'Đen / Trắng',
            'FB-031': 'Trắng / Đỏ',
            'VB-004': 'Xanh / Đỏ / Trắng',
            'VB-002': 'Vàng / Xanh',
            'VB-003': 'Vàng / Xanh',
            'VB-005': 'Xanh / Trắng',
            'VB-006': 'Vàng / Xanh',
            'VB-008': 'Vàng / Xanh',
            'VB-009': 'Xanh / Trắng',
            'VB-010': 'Trắng / Xanh',
            'VB-011': 'Trắng / Tím',
            'VB-007': 'Trắng / Đỏ / Xanh',
            'VB-012': 'Trắng / Đỏ',
            'VB-013': 'Đen / Bạc',
            'VB-014': 'Đen / Volt',
            'VB-015': 'Đen',
            'VB-016': 'Đen',
            'VB-017': 'Đỏ / Trắng',
            'VB-018': 'Trắng / Đen',
            'VB-019': 'Đen',
            'VB-020': 'Vàng / Xanh',
            'VB-022': 'Vàng / Xanh',
            'VB-023': 'Trắng / Xanh',
            'VB-024': 'Đen / Trắng',
            'VB-026': 'Trắng / Xanh',
            'VB-027': 'Đen / Xanh',
            'VB-028': 'Đen',
            'BB-009': 'Trắng / Xanh',
            'BB-010': 'Đen / Vàng',
            'BB-011': 'Đen / Trắng',
            'BB-012': 'Đỏ / Đen',
            'BB-013': 'Trắng / Cam',
            'BB-014': 'Xanh / Bạc',
            'BB-015': 'Cam / Đen',
            'BB-016': 'Cam / Đen',
            'BB-017': 'Đen / Đỏ',
            'BB-018': 'Nâu cam',
            'BB-019': 'Đen',
            'BB-020': 'Trắng / Đen',
            'BB-021': 'Đen',
            'BB-022': 'Đen / Xám',
            'BB-024': 'Đen / Đỏ',
            'BB-025': 'Xám / Đen',
            'BM-002': 'Đen / Bạc',
            'BM-006': 'Trắng / Xanh',
            'BM-007': 'Đen / Vàng',
            'BM-009': 'Xanh / Đen',
            'BM-010': 'Trắng',
            'BM-011': 'Vàng',
            'BM-012': 'Trắng',
            'BM-013': 'Trắng',
            'BM-014': 'Trắng / Xanh',
            'BM-016': 'Trắng / Xanh',
            'BM-017': 'Đen / Đỏ',
            'BM-018': 'Trắng',
            'BM-019': 'Vàng',
            'BM-020': 'Đen',
            'BM-021': 'Vàng',
            'BM-017': 'Đen / Đỏ'
        };

        if (overrides[sku]) {
            return overrides[sku];
        }

        const cleaned = sanitizeProductText(value);
        return repairQuestionMarkText(cleaned, sku, 'color');
    }

    function extractProductTail(value, keywords = []) {
        const cleaned = sanitizeProductText(value);
        for (const keyword of keywords) {
            const index = cleaned.indexOf(keyword);
            if (index >= 0) {
                return cleaned.slice(index).trim();
            }
        }
        return repairQuestionMarkText(cleaned, '', 'name');
    }

    function applyTextReplacements(value, replacements) {
        return replacements.reduce((result, [pattern, replacement]) => result.replace(pattern, replacement), value);
    }

    function applyLiteralReplacements(value, replacements) {
        return replacements.reduce((result, [from, to]) => result.split(from).join(to), value);
    }

    function repairQuestionMarkText(value, sku = '', field = 'text') {
        let result = String(value || '').trim();
        if (!result.includes('?')) {
            return result;
        }

        const literalCommonReplacements = [
            ['B?ng chuy?n', 'Bóng chuyền'],
            ['B?ng r?', 'Bóng rổ'],
            ['B?ng b?n', 'Bóng bàn'],
            ['c?u l?ng', 'cầu lông'],
            ['C?u l?ng', 'Cầu lông'],
            ['V?t', 'Vợt'],
            ['M?t v?t', 'Mặt vợt'],
            ['Gi?y', 'Giày'],
            ['B?o v? g?i', 'Bảo vệ gối'],
            ['B? l??i', 'Bộ lưới'],
            ['Keo d?n', 'Keo dán'],
            ['Balo b?ng r?', 'Balo bóng rổ'],
            ['?ng tay', 'Ống tay'],
            ['T?t', 'Tất'],
            ['T?i', 'Túi'],
            ['Qu?n c?n', 'Quấn cán'],
            ['C??c', 'Cước'],
            ['?o thi ??u', 'Áo thi đấu'],
            ['?o thi ?u', 'Áo thi đấu'],
            ['?o ', 'Áo '],
            ['b?i bi?n', 'bãi biển'],
            ['l?ng v?', 'lông vũ'],
            ['nh?a', 'nhựa'],
            ['l?p', 'lớp'],
            ['h?i', 'hơi'],
            ['Đ?ng L?c', 'Động Lực'],
            ['B?ng b?ng b?n', 'Bóng bóng bàn'],
            ['B?ng b?ng b????n', 'Bóng bóng bàn']
        ];

        const commonReplacements = [
            [/B\?+ng chuy\?+n/gi, 'Bóng chuyền'],
            [/B\?+ng r\?+/gi, 'Bóng rổ'],
            [/B\?+ng b\?+n/gi, 'Bóng bàn'],
            [/C\?+u l\?+ng/gi, 'Cầu lông'],
            [/c\?+u l\?+ng/gi, 'cầu lông'],
            [/V\?+t/gi, 'Vợt'],
            [/M\?+t v\?+t/gi, 'Mặt vợt'],
            [/Gi\?+y/gi, 'Giày'],
            [/B\?+o v\?+ g\?+i/gi, 'Bảo vệ gối'],
            [/B\?+ l\?+i/gi, 'Bộ lưới'],
            [/Keo d\?+n/gi, 'Keo dán'],
            [/Balo b\?+ng r\?+/gi, 'Balo bóng rổ'],
            [/\?+ng tay/gi, 'Ống tay'],
            [/T\?+t/gi, 'Tất'],
            [/T\?+i/gi, 'Túi'],
            [/Qu\?+n c\?+n/gi, 'Quấn cán'],
            [/C\?+c/gi, 'Cước'],
            [/\?+o thi \?+u/gi, 'Áo thi đấu'],
            [/\?+o\b/gi, 'Áo'],
            [/b\?+i bi\?+n/gi, 'bãi biển'],
            [/l\?+ng v\?+/gi, 'lông vũ'],
            [/nh\?+a/gi, 'nhựa'],
            [/l\?+p/gi, 'lớp']
        ];

        const literalSizeReplacements = [
            ['Ti?u chu?n / M?m', 'Tiêu chuẩn / Mềm'],
            ['Ti?u chu?n', 'Tiêu chuẩn'],
            ['S? 7', 'Số 7'],
            ['S? 5', 'Số 5'],
            ['12 qu?', '12 quả'],
            ['6 qu?', '6 quả'],
            ['6 c?y', '6 cây'],
            ['3 cu?n', '3 cuộn']
        ];

        const sizeReplacements = [
            [/Ti\?+u chu\?+n \/\s*M\?+m/gi, 'Tiêu chuẩn / Mềm'],
            [/Ti\?+u chu\?+n/gi, 'Tiêu chuẩn'],
            [/S\?+\s*7/gi, 'Số 7'],
            [/S\?+\s*5/gi, 'Số 5'],
            [/12 qu\?+/gi, '12 quả'],
            [/6 qu\?+/gi, '6 quả'],
            [/6 c\?+y/gi, '6 cây'],
            [/3 cu\?+n/gi, '3 cuộn']
        ];

        const literalColorReplacements = [
            ['Tr?ngng', 'Trắng'],
            ['Tr?ng', 'Trắng'],
            ['?en', 'Đen'],
            ['V?ng', 'Vàng'],
            ['X?m', 'Xám'],
            ['B?c', 'Bạc'],
            ['N??u cam', 'Nâu cam'],
            ['T??m', 'Tím'],
            ['?? / ?en', 'Đỏ / Đen'],
            ['?en / ??', 'Đen / Đỏ'],
            ['?? / Trắng', 'Đỏ / Trắng'],
            ['Trắng / ??', 'Trắng / Đỏ'],
            ['??', 'Đỏ']
        ];

        const colorReplacements = [
            [/Tr\?+/gi, 'Trắng'],
            [/V\?+ng/gi, 'Vàng'],
            [/X\?+m/gi, 'Xám'],
            [/B\?+c/gi, 'Bạc'],
            [/\?+en/gi, 'Đen'],
            [/\?{4,}/g, 'Đỏ']
        ];

        for (let round = 0; round < 3; round += 1) {
            const previous = result;

            result = applyLiteralReplacements(result, literalCommonReplacements);
            result = applyTextReplacements(result, commonReplacements);

            if (field === 'size') {
                result = applyLiteralReplacements(result, literalSizeReplacements);
                result = applyTextReplacements(result, sizeReplacements);
            }

            if (field === 'color') {
                result = applyLiteralReplacements(result, literalColorReplacements);
                result = applyTextReplacements(result, colorReplacements);
            }

            if (field === 'name') {
                result = applyLiteralReplacements(result, literalSizeReplacements);
                result = applyTextReplacements(result, sizeReplacements);
            }

            if (result === previous) {
                break;
            }
        }

        const sportPrefix = getSkuPrefix(sku);
        if (sportPrefix === 'VB' && result === 'Mikasa V390W') {
            return 'Bóng chuyền Mikasa V390W';
        }

        return result.replace(/\s+/g, ' ').trim();
    }

    function sanitizeProductText(value) {
        if (value === null || value === undefined) {
            return '';
        }

        let result = decodeMojibake(value);
        const phraseReplacements = [
            [/\u0002\uFFFDo khoác b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'Áo khoác bóng đá'],
            [/\u0002\uFFFDo tập b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'Áo tập bóng đá'],
            [/\u0002\uFFFDo b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'Áo bóng đá'],
            [/\u0002\uFFFDo thi \uFFFD\u0018ấu b\u0002\uFFFDng chuyền/g, 'Áo thi đấu bóng chuyền'],
            [/\u0002\uFFFDo b\u0002\uFFFDng chuyền/g, 'Áo bóng chuyền'],
            [/\u0002\uFFFDo b\u0002\uFFFDng r\uFFFD"/g, 'Áo bóng rổ'],
            [/Gi\u0002\uFFFDy b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'Giày bóng đá'],
            [/Gi\u0002\uFFFDy b\u0002\uFFFDng chuyền/g, 'Giày bóng chuyền'],
            [/Gi\u0002\uFFFDy b\u0002\uFFFDng r\uFFFD"/g, 'Giày bóng rổ'],
            [/Gi\u0002\uFFFDy cầu l\u0002\uFFFDng/g, 'Giày cầu lông'],
            [/Vợt b\u0002\uFFFDng b\u0002\uFFFDn/g, 'Vợt bóng bàn'],
            [/Mặt vợt b\u0002\uFFFDng b\u0002\uFFFDn/g, 'Mặt vợt bóng bàn'],
            [/B\u0002\uFFFDng b\u0002\uFFFDng b\u0002\uFFFDn/g, 'Bóng bóng bàn'],
            [/Bảo v\uFFFD! g\uFFFD\u0018i/g, 'Bảo vệ gối'],
            [/B\uFFFD" lư\uFFFD:i b\u0002\uFFFDng b\u0002\uFFFDn/g, 'Bộ lưới bóng bàn'],
            [/Keo d\u0002\uFFFDn mặt vợt/g, 'Keo dán mặt vợt'],
            [/T\u0002\uFFFDi tr\uFFFD\u0018ng b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'Túi trống bóng đá'],
            [/T\u0002\uFFFDi cầu l\u0002\uFFFDng/g, 'Túi cầu lông'],
            [/Quấn c\u0002\uFFFDn cầu l\u0002\uFFFDng/g, 'Quấn cán cầu lông'],
            [/Cư\uFFFD:c cầu l\u0002\uFFFDng/g, 'Cước cầu lông'],
            [/Ống \uFFFD\u0018\uFFFD\u001Cng b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'Ống đồng bóng đá'],
            [/b\u0002\uFFFDng chuyền/g, 'bóng chuyền'],
            [/b\u0002\uFFFDng b\u0002\uFFFDn/g, 'bóng bàn'],
            [/b\u0002\uFFFDng r\uFFFD"/g, 'bóng rổ'],
            [/b\u0002\uFFFDng \uFFFD\u0018\u0002\uFFFD/g, 'bóng đá'],
            [/cầu l\u0002\uFFFDng/g, 'cầu lông']
        ];

        phraseReplacements.forEach(([pattern, replacement]) => {
            result = result.replace(pattern, replacement);
        });

        result = result
            .replace(/[\u0000-\u001F]/g, '')
            .replace(/\uFFFD/g, '')
            .replace(/\s+/g, ' ')
            .trim();

        return result;
    }

    function getCanonicalSportFromProduct(product) {
        return getCanonicalSportFromSku(product?.sku, product?.danh_muc);
    }

    function getCanonicalSportFromSku(sku, fallback = '') {
        const sportMap = {
            FB: 'Bóng đá',
            VB: 'Bóng chuyền',
            BB: 'Bóng rổ',
            TT: 'Bóng bàn',
            BM: 'Cầu lông'
        };
        return sportMap[getSkuPrefix(sku)] || sanitizeProductText(fallback) || 'Khác';
    }

    function getMenuItemIdsForProduct(product) {
        const skuPrefix = getSkuPrefix(product?.sku);
        const skuNumber = getSkuNumber(product?.sku);
        const itemIds = [];

        if (!skuPrefix || !Number.isFinite(skuNumber)) {
            return itemIds;
        }

        if (skuPrefix === 'FB') {
            pushItemId(itemIds, skuNumber === 16 || skuNumber === 27, 'football-ball');
            pushItemId(itemIds, skuNumber === 1 || isSkuBetween(skuNumber, 7, 15), 'football-shoes');
            pushItemId(itemIds, skuNumber === 3 || isSkuBetween(skuNumber, 17, 22), 'football-apparel');
            pushItemId(itemIds, skuNumber === 26, 'football-gloves');
            pushItemId(itemIds, skuNumber === 25, 'football-shinguards');
            pushItemId(itemIds, skuNumber === 28 || skuNumber === 29, 'football-socks');
            pushItemId(itemIds, skuNumber === 30 || skuNumber === 31, 'football-towels');
            pushItemId(itemIds, skuNumber === 23 || skuNumber === 24, 'football-backpacks');
        }

        if (skuPrefix === 'VB') {
            pushItemId(itemIds, skuNumber === 1 || isSkuBetween(skuNumber, 2, 9) || skuNumber === 20 || skuNumber === 22, 'volleyball-ball');
            pushItemId(itemIds, isSkuBetween(skuNumber, 10, 14) || skuNumber === 21, 'volleyball-shoes');
            pushItemId(itemIds, skuNumber === 17 || skuNumber === 18, 'volleyball-apparel');
            pushItemId(itemIds, skuNumber === 15 || skuNumber === 16 || skuNumber === 19, 'volleyball-kneepads');
            pushItemId(itemIds, skuNumber === 23 || skuNumber === 24, 'volleyball-socks');
            pushItemId(itemIds, skuNumber === 25 || skuNumber === 26, 'volleyball-towels');
            pushItemId(itemIds, skuNumber === 27 || skuNumber === 28, 'volleyball-backpacks');
        }

        if (skuPrefix === 'BB') {
            pushItemId(itemIds, skuNumber === 2 || isSkuBetween(skuNumber, 3, 8) || skuNumber === 15 || skuNumber === 16 || skuNumber === 18 || skuNumber === 23, 'basketball-ball');
            pushItemId(itemIds, isSkuBetween(skuNumber, 9, 14), 'basketball-shoes');
            pushItemId(itemIds, skuNumber === 21, 'basketball-apparel');
            pushItemId(itemIds, skuNumber === 20, 'basketball-socks');
            pushItemId(itemIds, skuNumber === 19, 'basketball-arm-sleeves');
            pushItemId(itemIds, skuNumber === 24 || skuNumber === 25, 'basketball-towels');
            pushItemId(itemIds, skuNumber === 22, 'basketball-backpacks');
            pushItemId(itemIds, skuNumber === 17, 'basketball-training-gear');
        }

        if (skuPrefix === 'TT') {
            pushItemId(itemIds, skuNumber === 1 || isSkuBetween(skuNumber, 7, 16) || skuNumber === 27, 'tabletennis-racket');
            pushItemId(itemIds, isSkuBetween(skuNumber, 17, 21), 'tabletennis-rubber');
            pushItemId(itemIds, isSkuBetween(skuNumber, 22, 24), 'tabletennis-ball');
            pushItemId(itemIds, skuNumber === 25 || skuNumber === 26, 'tabletennis-accessories');
            pushItemId(itemIds, skuNumber === 28 || skuNumber === 29, 'tabletennis-apparel');
        }

        if (skuPrefix === 'BM') {
            pushItemId(itemIds, isSkuBetween(skuNumber, 1, 9) || skuNumber === 22, 'badminton-racket');
            pushItemId(itemIds, isSkuBetween(skuNumber, 10, 13), 'badminton-shuttlecock');
            pushItemId(itemIds, isSkuBetween(skuNumber, 14, 17), 'badminton-shoes');
            pushItemId(itemIds, skuNumber === 18 || skuNumber === 19 || skuNumber === 21, 'badminton-strings');
            pushItemId(itemIds, skuNumber === 20, 'badminton-accessories');
            pushItemId(itemIds, skuNumber === 23 || skuNumber === 24, 'badminton-apparel');
        }

        return itemIds;
    }

    function pushItemId(itemIds, condition, itemId) {
        if (condition) {
            itemIds.push(itemId);
        }
    }

    function getSkuPrefix(sku) {
        return String(sku || '').trim().toUpperCase().split('-')[0] || '';
    }

    function getSkuNumber(sku) {
        const parts = String(sku || '').trim().toUpperCase().split('-');
        return parts.length > 1 ? Number(parts[1]) : NaN;
    }

    function isSkuBetween(value, start, end) {
        return Number.isFinite(value) && value >= start && value <= end;
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
        const data = text ? normalizePayload(safeJsonParse(text)) : null;

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

    function normalizeText(value) {
        return decodeMojibake(value)
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toLowerCase()
            .trim();
    }

    function formatCurrency(value) {
        return `${new Intl.NumberFormat('vi-VN').format(Number(value || 0))}\u0111`;
    }

    function isStrongPassword(password) {
        return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{6,}$/.test(String(password || ''));
    }

    function canManageProducts() {
        const role = getCanonicalRole(currentUser?.role);
        return ['Qu\u1ea3n tr\u1ecb vi\u00ean', 'Nh\u00e2n vi\u00ean'].includes(role);
    }

    function isAdmin() {
        return getCanonicalRole(currentUser?.role) === 'Qu\u1ea3n tr\u1ecb vi\u00ean';
    }

    function getRoleClass(role) {
        const canonicalRole = getCanonicalRole(role);
        if (canonicalRole === 'Qu\u1ea3n tr\u1ecb vi\u00ean') {
            return 'role-admin';
        }
        if (canonicalRole === 'Nh\u00e2n vi\u00ean') {
            return 'role-employee';
        }
        return 'role-customer';
    }

    function getCanonicalRole(role) {
        const normalizedRole = normalizeText(role);
        if (normalizedRole.includes('quan tri')) {
            return 'Qu\u1ea3n tr\u1ecb vi\u00ean';
        }
        if (normalizedRole.includes('nhan vien')) {
            return 'Nh\u00e2n vi\u00ean';
        }
        if (normalizedRole.includes('khach hang')) {
            return 'Kh\u00e1ch h\u00e0ng';
        }
        return decodeMojibake(role || '');
    }

    function decodeMojibake(value) {
        let result = String(value ?? '');
        const mojibakeMarkers = [
            '\u00c3', '\u00c2', '\u00c4', '\u00c5', '\u00c6',
            '\u00e1\u00bb', '\u00e1\u00ba', '\u00c4\u0091'
        ];

        for (let attempt = 0; attempt < 3; attempt += 1) {
            if (!mojibakeMarkers.some(marker => result.includes(marker))) {
                break;
            }

            try {
                const bytes = Uint8Array.from(Array.from(result, char => char.charCodeAt(0) & 0xff));
                const decoded = new TextDecoder('utf-8').decode(bytes);
                if (!decoded || decoded === result) {
                    break;
                }
                result = decoded;
            } catch (error) {
                break;
            }
        }
        return result;
    }

    function normalizePayload(value) {
        if (Array.isArray(value)) {
            return value.map(item => normalizePayload(item));
        }

        if (value && typeof value === 'object') {
            return Object.fromEntries(
                Object.entries(value).map(([key, item]) => [key, normalizePayload(item)])
            );
        }

        if (typeof value === 'string') {
            return sanitizeProductText(value);
        }

        return value;
    }

    function repairTextNodes(root = document.body) {
        if (!root) {
            return;
        }

        const target = root.nodeType === Node.ELEMENT_NODE ? root : document.body;
        const walker = document.createTreeWalker(target, NodeFilter.SHOW_TEXT);
        const textNodes = [];

        while (walker.nextNode()) {
            textNodes.push(walker.currentNode);
        }

        textNodes.forEach(node => {
            const repaired = sanitizeProductText(node.nodeValue);
            if (repaired !== node.nodeValue) {
                node.nodeValue = repaired;
            }
        });

        if (!(target instanceof Element)) {
            return;
        }

        target.querySelectorAll('*').forEach(element => {
            ['alt', 'aria-label', 'placeholder', 'title'].forEach(attribute => {
                if (!element.hasAttribute(attribute)) {
                    return;
                }

                const currentValue = element.getAttribute(attribute);
                const repaired = sanitizeProductText(currentValue);
                if (repaired !== currentValue) {
                    element.setAttribute(attribute, repaired);
                }
            });
        });
    }

    function getWishlistIds() {
        const wishlistIds = readStorage(WISHLIST_KEY, []);
        if (!Array.isArray(wishlistIds)) {
            return [];
        }

        return Array.from(new Set(
            wishlistIds
                .map(item => String(item || '').trim())
                .filter(Boolean)
        ));
    }

    function saveWishlistIds(ids) {
        const normalizedIds = Array.from(new Set(
            (Array.isArray(ids) ? ids : [])
                .map(item => String(item || '').trim())
                .filter(Boolean)
        ));

        if (!normalizedIds.length) {
            localStorage.removeItem(WISHLIST_KEY);
            updateWishlistCount();
            return;
        }

        localStorage.setItem(WISHLIST_KEY, JSON.stringify(normalizedIds));
        updateWishlistCount();
    }

    function updateWishlistCount() {
        wishlistCount.textContent = String(getWishlistIds().length);
    }

    function isWishlisted(productId) {
        return getWishlistIds().includes(String(productId));
    }

    function getWishlistProducts() {
        const wishlistIds = getWishlistIds();
        const wishlistOrder = new Map(wishlistIds.map((id, index) => [id, index]));

        return allProducts
            .filter(product => wishlistOrder.has(String(product.id)))
            .sort((left, right) => wishlistOrder.get(String(left.id)) - wishlistOrder.get(String(right.id)));
    }

    function renderProducts(products) {
        if (!products.length) {
            productContainer.innerHTML = '<p class="loading-text">Không có sản phẩm phù hợp với bộ lọc hiện tại.</p>';
            return;
        }

        productContainer.innerHTML = products.map(product => {
            const badge = product.ton_kho <= 3
                ? '<span class="badge danger">Sap het</span>'
                : (product.ton_kho <= 10 ? '<span class="badge warning">Ban chay</span>' : '');
            const favoriteActive = isWishlisted(product.id) ? 'active' : '';
            const favoriteLabel = isWishlisted(product.id) ? 'Bỏ khỏi yêu thích' : 'Thêm vào yêu thích';

            return `
                <article class="product-card">
                    <div class="product-img">
                        ${badge}
                        <button
                            class="wishlist-toggle-btn ${favoriteActive}"
                            type="button"
                            data-favorite-toggle
                            data-product-id="${product.id}"
                            aria-label="${favoriteLabel}"
                            title="${favoriteLabel}"
                        >
                            <i class="fa-solid fa-heart"></i>
                        </button>
                        <img src="${escapeHtml(getProductImageUrl(product))}" alt="${escapeHtml(product.ten_san_pham)}" loading="lazy">
                    </div>
                    <div class="product-info">
                        <p class="product-category">${escapeHtml(product.danh_muc || '')}</p>
                        <h3 class="product-name">${escapeHtml(product.ten_san_pham || '')}</h3>
                        <p class="product-subcategory">${escapeHtml(getProductGroupLabel(product))}</p>
                        <div class="product-meta">
                            <span>${escapeHtml(product.thuong_hieu || 'Khong ro')}</span>
                            <span>${escapeHtml(normalizeSizeValue(product.size) || '--')}</span>
                        </div>
                        <p class="product-price">${formatCurrency(product.gia_ban)}</p>
                        <p class="product-stock">Ton kho: ${product.ton_kho ?? 0}</p>
                        <button class="add-to-cart-btn" type="button" data-product-id="${product.id}">Thêm vào giỏ</button>
                    </div>
                </article>
            `;
        }).join('');
    }

    function renderWishlistView() {
        const wishlistProducts = getWishlistProducts();
        const hasItems = wishlistProducts.length > 0;

        wishlistEmptyState.classList.toggle('hidden', hasItems);
        wishlistGrid.classList.toggle('hidden', !hasItems);

        if (!hasItems) {
            wishlistGrid.innerHTML = '';
            return;
        }

        wishlistGrid.innerHTML = wishlistProducts.map(product => `
            <article class="wishlist-card">
                <button
                    class="wishlist-card-remove"
                    type="button"
                    data-wishlist-remove
                    data-product-id="${product.id}"
                    aria-label="Xóa khỏi yêu thích"
                    title="Xóa khỏi yêu thích"
                >
                    <i class="fa-solid fa-xmark"></i>
                </button>
                <div class="wishlist-card-image">
                    <img src="${escapeHtml(getProductImageUrl(product))}" alt="${escapeHtml(product.ten_san_pham || 'San pham')}" loading="lazy">
                </div>
                <div class="wishlist-card-body">
                    <p class="product-category">${escapeHtml(product.danh_muc || '')}</p>
                    <h3 class="wishlist-card-title" title="${escapeHtml(product.ten_san_pham || '')}">${escapeHtml(product.ten_san_pham || '')}</h3>
                    <p class="product-subcategory wishlist-card-group" title="${escapeHtml(getProductGroupLabel(product))}">${escapeHtml(getProductGroupLabel(product))}</p>
                    <div class="wishlist-card-meta">
                        <span>${escapeHtml(product.thuong_hieu || 'Khong ro')}</span>
                        <span>${escapeHtml(normalizeSizeValue(product.size) || 'Tieu chuan')}</span>
                    </div>
                    <div class="wishlist-card-footer">
                        <p class="product-price">${formatCurrency(product.gia_ban)}</p>
                        <div class="wishlist-card-actions">
                            <button class="secondary-btn text-bold" type="button" data-wishlist-remove data-product-id="${product.id}">Xóa</button>
                            <button class="login-submit-btn text-bold" type="button" data-wishlist-move data-product-id="${product.id}">Bỏ vào giỏ</button>
                        </div>
                    </div>
                </div>
            </article>
        `).join('');

        repairRenderedContent();
    }

    function renderCatalog() {
        const shouldSwitchToCatalog = currentView !== 'cart'
            || Boolean(currentCollectionId)
            || currentCategory !== 'all'
            || Boolean(currentMenuItemId)
            || Boolean(currentBrand)
            || currentPriceRange !== 'all'
            || currentTypeFilter !== 'all'
            || currentSizeFilter !== 'all'
            || currentSortOption !== 'featured'
            || Boolean(currentQuery);

        if (shouldSwitchToCatalog) {
            currentView = 'catalog';
        }

        const baseProducts = getBaseProducts();
        const filteredProducts = getFilteredProducts(baseProducts);
        renderProducts(filteredProducts);
        renderCatalogHeader(filteredProducts);
        renderCollectionView(baseProducts, filteredProducts);
        renderActiveFilters();
        renderMegaMenu();
        renderCartView();
        renderWishlistView();
        syncMainView();
        syncNavState();
        repairRenderedContent();
    }

    function updateCartCount() {
        const totalItems = getCartItems().reduce((sum, item) => sum + Number(item.quantity || 0), 0);
        cartCount.textContent = String(totalItems);
    }

    function addToCart(productId) {
        openCartConfigurator(productId);
    }

    function getCartItems() {
        const storedItems = readStorage(CART_KEY, []);
        if (!Array.isArray(storedItems)) {
            return [];
        }

        const cartMap = new Map();

        storedItems.forEach(rawItem => {
            const productId = String(rawItem?.productId ?? rawItem?.id ?? '').trim();
            if (!productId) {
                return;
            }

            const product = findProductById(productId);
            const sizeOptions = getProductSizeOptions(product);
            const fallbackSize = sizeOptions[0] || 'Tieu chuan';
            const size = String(rawItem?.size || fallbackSize).trim() || fallbackSize;
            const lineId = buildCartLineId(productId, size);
            const quantity = Math.max(1, Math.round(Number(rawItem?.quantity || 1)));
            const selected = rawItem?.selected !== false;

            if (cartMap.has(lineId)) {
                const existing = cartMap.get(lineId);
                existing.quantity += quantity;
                existing.selected = existing.selected || selected;
                return;
            }

            cartMap.set(lineId, {
                lineId,
                productId,
                size,
                quantity,
                selected
            });
        });

        return Array.from(cartMap.values());
    }

    function saveCartItems(items) {
        if (!Array.isArray(items) || !items.length) {
            localStorage.removeItem(CART_KEY);
            updateCartCount();
            return;
        }

        const normalizedItems = items.map(item => ({
            lineId: String(item.lineId || buildCartLineId(item.productId, item.size)),
            productId: String(item.productId),
            size: String(item.size || 'Tieu chuan'),
            quantity: Math.max(1, Math.round(Number(item.quantity || 1))),
            selected: item.selected !== false
        }));

        localStorage.setItem(CART_KEY, JSON.stringify(normalizedItems));
        updateCartCount();
    }

    function findProductById(productId) {
        return allProducts.find(product => String(product.id) === String(productId)) || null;
    }

    function buildCartLineId(productId, size) {
        const sizeKey = normalizeText(size || 'Tieu chuan').replace(/\s+/g, '-') || 'tieu-chuan';
        return `${String(productId)}::${sizeKey}`;
    }

    function getProductSizeOptions(product) {
        const rawSize = normalizeSizeValue(product?.size);
        if (!rawSize) {
            return ['Tieu chuan'];
        }

        const compact = rawSize.replace(/\s+/g, ' ').trim();
        const numericRange = compact.match(/^(\d+)\s*-\s*(\d+)$/);
        if (numericRange) {
            const start = Number(numericRange[1]);
            const end = Number(numericRange[2]);
            if (end >= start && end - start <= 10) {
                return Array.from({ length: end - start + 1 }, (_, index) => String(start + index));
            }
        }

        const apparelScale = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL', '2XL', '3XL'];
        const apparelRange = compact.toUpperCase().match(/^(XXS|XS|S|M|L|XL|XXL|XXXL|2XL|3XL)\s*-\s*(XXS|XS|S|M|L|XL|XXL|XXXL|2XL|3XL)$/);
        if (apparelRange) {
            const startIndex = apparelScale.indexOf(apparelRange[1]);
            const endIndex = apparelScale.indexOf(apparelRange[2]);
            if (startIndex !== -1 && endIndex !== -1 && endIndex >= startIndex) {
                return apparelScale.slice(startIndex, endIndex + 1);
            }
        }

        if (/[\/,|]/.test(compact)) {
            return compact
                .split(/[\/,|]/)
                .map(part => part.trim())
                .filter(Boolean);
        }

        return [compact];
    }

    function getHydratedCartItems() {
        return getCartItems()
            .map(item => {
                const product = findProductById(item.productId);
                if (!product) {
                    return null;
                }

                const sizeOptions = getProductSizeOptions(product);
                const resolvedSize = sizeOptions.includes(item.size) ? item.size : (sizeOptions[0] || 'Tieu chuan');
                const maxQuantity = getCartLineMaxQuantity(product);
                const quantity = Math.min(Math.max(1, Number(item.quantity || 1)), maxQuantity);

                return {
                    ...item,
                    lineId: buildCartLineId(item.productId, resolvedSize),
                    size: resolvedSize,
                    quantity,
                    sizeOptions,
                    product,
                    unitPrice: Number(product.gia_ban || 0),
                    subtotal: Number(product.gia_ban || 0) * quantity
                };
            })
            .filter(Boolean);
    }

    function getCartLineMaxQuantity(product) {
        const stock = Number(product?.ton_kho ?? 0);
        return Math.max(1, stock > 0 ? stock : 1);
    }

    function openCartConfigurator(productId, options = {}) {
        const product = findProductById(productId);
        if (!product) {
            return;
        }

        if (Number(product.ton_kho || 0) <= 0) {
            alert('San pham nay da het hang.');
            return;
        }

        const maxQuantity = getCartLineMaxQuantity(product);
        const sizeOptions = getProductSizeOptions(product);

        cartConfigProductId.value = String(product.id);
        cartConfigImage.src = getProductImageUrl(product);
        cartConfigImage.alt = product.ten_san_pham || 'San pham';
        cartConfigCategory.textContent = product.danh_muc || getCanonicalSportFromProduct(product);
        cartConfigName.textContent = product.ten_san_pham || 'San pham';
        cartConfigBrand.textContent = product.thuong_hieu || 'Khong ro thuong hieu';
        cartConfigPrice.textContent = formatCurrency(product.gia_ban);
        cartConfigStock.textContent = `Con lai ${product.ton_kho ?? 0} san pham.`;
        cartConfigSize.innerHTML = sizeOptions.map(size => `<option value="${escapeHtml(size)}">${escapeHtml(size)}</option>`).join('');
        cartConfigQuantity.value = '1';
        cartConfigQuantity.max = String(maxQuantity);
        cartItemError.textContent = '';
        cartItemError.classList.add('hidden');
        pendingWishlistMoveProductId = options.removeFromWishlist ? String(product.id) : '';
        openOverlay(cartItemOverlay);
    }

    function confirmAddToCart() {
        const product = findProductById(cartConfigProductId.value);
        if (!product) {
            return;
        }

        if (Number(product.ton_kho || 0) <= 0) {
            cartItemError.textContent = 'San pham nay tam thoi da het hang.';
            cartItemError.classList.remove('hidden');
            return;
        }

        const quantity = Math.max(1, Math.round(Number(cartConfigQuantity.value || 1)));
        const size = String(cartConfigSize.value || getProductSizeOptions(product)[0] || 'Tieu chuan').trim();
        const lineId = buildCartLineId(product.id, size);
        const maxQuantity = getCartLineMaxQuantity(product);
        const cartItems = getCartItems();
        const existingLine = cartItems.find(item => item.lineId === lineId);
        const nextQuantity = (existingLine?.quantity || 0) + quantity;

        if (nextQuantity > maxQuantity) {
            cartItemError.textContent = `So luong toi da cho san pham nay la ${maxQuantity}.`;
            cartItemError.classList.remove('hidden');
            return;
        }

        if (existingLine) {
            existingLine.quantity = nextQuantity;
            existingLine.selected = true;
        } else {
            cartItems.push({
                lineId,
                productId: String(product.id),
                size,
                quantity,
                selected: true
            });
        }

        saveCartItems(cartItems);
        if (pendingWishlistMoveProductId === String(product.id)) {
            const nextWishlistIds = getWishlistIds().filter(id => id !== String(product.id));
            saveWishlistIds(nextWishlistIds);
        }
        resetCartConfiguratorState();
        renderCartView();
        renderWishlistView();
        closeOverlay(cartItemOverlay);
        if (currentView === 'wishlist') {
            syncMainView();
        } else {
            renderCatalog();
        }
        alert(`Da them "${product.ten_san_pham}" vao gio hang.`);
    }

    function renderCartView() {
        const cartItems = getHydratedCartItems();
        const selectedItems = cartItems.filter(item => item.selected);
        const selectedQuantity = selectedItems.reduce((sum, item) => sum + item.quantity, 0);
        const subtotal = selectedItems.reduce((sum, item) => sum + item.subtotal, 0);
        const shipping = 0;
        const total = subtotal + shipping;

        const hasItems = cartItems.length > 0;
        cartEmptyState.classList.toggle('hidden', hasItems);
        cartContent.classList.toggle('hidden', !hasItems);

        if (!hasItems) {
            cartItemsContainer.innerHTML = '';
            cartSelectAllCheckbox.checked = false;
            cartSelectAllCheckbox.indeterminate = false;
            cartSelectionSummary.textContent = '0 san pham duoc chon';
            cartSummaryCount.textContent = '0';
            cartSummarySubtotal.textContent = formatCurrency(0);
            cartSummaryShipping.textContent = formatCurrency(0);
            cartSummaryTotal.textContent = formatCurrency(0);
            checkoutBtn.disabled = true;
            removeSelectedBtn.disabled = true;
            return;
        }

        cartItemsContainer.innerHTML = cartItems.map(item => {
            const sizeOptions = item.sizeOptions.map(size => `
                <option value="${escapeHtml(size)}" ${size === item.size ? 'selected' : ''}>${escapeHtml(size)}</option>
            `).join('');

            return `
                <article class="cart-item cart-table">
                    <div class="cart-col-product">
                        <div class="cart-product-cell">
                            <label class="cart-row-check">
                                <input type="checkbox" data-cart-select data-line-id="${escapeHtml(item.lineId)}" ${item.selected ? 'checked' : ''}>
                            </label>
                            <div class="cart-product-image">
                                <img src="${escapeHtml(getProductImageUrl(item.product))}" alt="${escapeHtml(item.product.ten_san_pham || 'San pham')}" loading="lazy">
                            </div>
                            <div class="cart-product-info">
                                <p class="product-category cart-product-category">${escapeHtml(item.product.danh_muc || '')}</p>
                                <h3 class="cart-product-title" title="${escapeHtml(item.product.ten_san_pham || '')}">${escapeHtml(item.product.ten_san_pham || '')}</h3>
                                <p class="product-subcategory cart-product-group" title="${escapeHtml(getProductGroupLabel(item.product))}">${escapeHtml(getProductGroupLabel(item.product))}</p>
                                <div class="cart-product-meta">
                                    <span title="${escapeHtml(item.product.thuong_hieu || 'Khong ro')}">${escapeHtml(item.product.thuong_hieu || 'Khong ro')}</span>
                                    <span>Ton kho: ${item.product.ton_kho ?? 0}</span>
                                </div>
                                <div class="cart-size-row">
                                    <label for="cart-size-${escapeHtml(item.lineId)}">Size</label>
                                    <select id="cart-size-${escapeHtml(item.lineId)}" data-cart-size-select data-line-id="${escapeHtml(item.lineId)}">
                                        ${sizeOptions}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cart-col-price cart-mobile-field" data-label="Don gia">
                        <p class="cart-price">${formatCurrency(item.unitPrice)}</p>
                    </div>
                    <div class="cart-col-quantity cart-mobile-field" data-label="So luong">
                        <div class="quantity-editor">
                            <button class="qty-btn" type="button" data-cart-action="decrease" data-line-id="${escapeHtml(item.lineId)}"><i class="fa-solid fa-minus"></i></button>
                            <input
                                type="number"
                                min="1"
                                max="${getCartLineMaxQuantity(item.product)}"
                                value="${item.quantity}"
                                data-cart-quantity-input
                                data-line-id="${escapeHtml(item.lineId)}"
                            >
                            <button class="qty-btn" type="button" data-cart-action="increase" data-line-id="${escapeHtml(item.lineId)}"><i class="fa-solid fa-plus"></i></button>
                        </div>
                    </div>
                    <div class="cart-col-subtotal cart-mobile-field" data-label="So tien">
                        <p class="cart-subtotal">${formatCurrency(item.subtotal)}</p>
                    </div>
                    <div class="cart-col-action cart-mobile-field" data-label="Thao tac">
                        <div class="cart-actions">
                            <button class="cart-text-btn" type="button" data-cart-action="remove" data-line-id="${escapeHtml(item.lineId)}">Xóa</button>
                        </div>
                    </div>
                </article>
            `;
        }).join('');

        const allSelected = cartItems.every(item => item.selected);
        const hasSelected = cartItems.some(item => item.selected);
        cartSelectAllCheckbox.checked = allSelected;
        cartSelectAllCheckbox.indeterminate = !allSelected && hasSelected;
        cartSelectionSummary.textContent = `${selectedQuantity} san pham duoc chon`;
        cartSummaryCount.textContent = String(selectedQuantity);
        cartSummarySubtotal.textContent = formatCurrency(subtotal);
        cartSummaryShipping.textContent = formatCurrency(shipping);
        cartSummaryTotal.textContent = formatCurrency(total);
        checkoutBtn.disabled = !hasSelected;
        removeSelectedBtn.disabled = !hasSelected;
        repairRenderedContent();
    }

    function syncMainView() {
        const isCartView = currentView === 'cart';
        const isWishlistView = currentView === 'wishlist';

        cartView.classList.toggle('hidden', !isCartView);
        wishlistView.classList.toggle('hidden', !isWishlistView);

        if (isCartView || isWishlistView) {
            catalogToolbar.classList.add('hidden');
            collectionView.classList.add('hidden');
            activeFilters.classList.add('hidden');
            productContainer.classList.add('hidden');
            closeMegaMenu();
            return;
        }

        productContainer.classList.remove('hidden');
    }

    function openCartView() {
        currentView = 'cart';
        renderCartView();
        syncMainView();
    }

    function openWishlistView() {
        currentView = 'wishlist';
        renderWishlistView();
        syncMainView();
    }

    function showCatalogView() {
        currentView = 'catalog';
        renderCatalog();
    }

    function goToHomePage() {
        userDropdown.classList.add('hidden');
        closeMegaMenu();
        currentView = 'catalog';
        resetCatalogState({ clearQuery: true });
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function removeFromWishlist(productId, options = {}) {
        const nextWishlistIds = getWishlistIds().filter(id => id !== String(productId));
        saveWishlistIds(nextWishlistIds);

        if (options.skipRender) {
            return;
        }

        if (currentView === 'wishlist') {
            renderWishlistView();
            syncMainView();
            return;
        }

        renderCatalog();
    }

    function toggleWishlistProduct(productId) {
        const productIdString = String(productId);
        const wishlistIds = getWishlistIds();

        if (wishlistIds.includes(productIdString)) {
            removeFromWishlist(productIdString);
            return;
        }

        wishlistIds.unshift(productIdString);
        saveWishlistIds(wishlistIds);

        if (currentView === 'wishlist') {
            renderWishlistView();
            syncMainView();
            return;
        }

        renderCatalog();
    }

    function removeCartLine(lineId) {
        const nextItems = getCartItems().filter(item => item.lineId !== lineId);
        saveCartItems(nextItems);
        renderCartView();
        syncMainView();
    }

    function updateCartLineQuantity(lineId, delta) {
        const cartItems = getCartItems();
        const targetItem = cartItems.find(item => item.lineId === lineId);
        if (!targetItem) {
            return;
        }

        setCartLineQuantity(lineId, Number(targetItem.quantity || 1) + delta);
    }

    function setCartLineQuantity(lineId, value) {
        const cartItems = getCartItems();
        const targetItem = cartItems.find(item => item.lineId === lineId);
        if (!targetItem) {
            return;
        }

        const product = findProductById(targetItem.productId);
        const maxQuantity = getCartLineMaxQuantity(product);
        const normalizedValue = Math.round(Number(value || 1));

        if (normalizedValue <= 0) {
            removeCartLine(lineId);
            return;
        }

        targetItem.quantity = Math.min(Math.max(1, normalizedValue), maxQuantity);
        saveCartItems(cartItems);
        renderCartView();
    }

    function updateCartLineSize(lineId, size) {
        const cartItems = getCartItems();
        const targetIndex = cartItems.findIndex(item => item.lineId === lineId);
        if (targetIndex === -1) {
            return;
        }

        const targetItem = cartItems[targetIndex];
        const nextSize = String(size || '').trim() || targetItem.size;
        const nextLineId = buildCartLineId(targetItem.productId, nextSize);

        if (nextLineId === lineId) {
            return;
        }

        const duplicateIndex = cartItems.findIndex(item => item.lineId === nextLineId);
        if (duplicateIndex !== -1) {
            cartItems[duplicateIndex].quantity += targetItem.quantity;
            cartItems[duplicateIndex].selected = cartItems[duplicateIndex].selected || targetItem.selected;
            cartItems.splice(targetIndex, 1);
        } else {
            targetItem.size = nextSize;
            targetItem.lineId = nextLineId;
        }

        saveCartItems(cartItems);
        renderCartView();
    }

    function toggleCartLineSelection(lineId, checked) {
        const cartItems = getCartItems();
        const targetItem = cartItems.find(item => item.lineId === lineId);
        if (!targetItem) {
            return;
        }

        targetItem.selected = checked;
        saveCartItems(cartItems);
        renderCartView();
    }

    function removeSelectedCartItems() {
        const cartItems = getCartItems();
        const selectedItems = cartItems.filter(item => item.selected);
        if (!selectedItems.length) {
            alert('Hay chon it nhat mot san pham de xoa.');
            return;
        }

        if (!confirm(`Ban muon xoa ${selectedItems.length} dong san pham da chon khoi gio hang?`)) {
            return;
        }

        saveCartItems(cartItems.filter(item => !item.selected));
        renderCartView();
        syncMainView();
    }

    function handleCheckout() {
        const cartItems = getHydratedCartItems();
        const selectedItems = cartItems.filter(item => item.selected);
        if (!selectedItems.length) {
            alert('Hay chon it nhat mot san pham de thanh toan.');
            return;
        }

        if (!currentUser) {
            loginError.textContent = 'Hay dang nhap truoc khi thanh toan.';
            loginError.classList.remove('hidden');
            openOverlay(loginOverlay);
            return;
        }

        const total = selectedItems.reduce((sum, item) => sum + item.subtotal, 0);
        if (!confirm(`Xac nhan thanh toan ${selectedItems.length} dong san pham voi tong gia tri ${formatCurrency(total)}?`)) {
            return;
        }

        const remainingItems = getCartItems().filter(item => !item.selected);
        saveCartItems(remainingItems);
        renderCartView();
        syncMainView();
        alert('Thanh toan thanh cong. Don hang cua ban da duoc ghi nhan o frontend demo.');
    }

    function resetCartConfiguratorState() {
        pendingWishlistMoveProductId = '';
        cartItemError.textContent = '';
        cartItemError.classList.add('hidden');
    }

    function closeOverlay(overlay) {
        if (!overlay) {
            return;
        }

        if (overlay === cartItemOverlay) {
            resetCartConfiguratorState();
        }

        overlay.classList.add('hidden');
    }

    cartConfigQuantity.addEventListener('input', () => {
        const product = findProductById(cartConfigProductId.value);
        const maxQuantity = getCartLineMaxQuantity(product);
        const nextValue = Math.min(Math.max(1, Number(cartConfigQuantity.value || 1)), maxQuantity);
        cartConfigQuantity.value = String(nextValue);
    });

    function repairRenderedContent() {
        repairTextNodes(document.body);
    }
});
