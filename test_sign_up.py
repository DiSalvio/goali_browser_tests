from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.core.utils import ChromeType
from faker import Faker

chrome_options = Options()
chrome_options.add_argument("--headless")
driver = webdriver.Chrome(service=Service(ChromeDriverManager(chrome_type=ChromeType.BRAVE).install()), options=chrome_options)
driver.implicitly_wait(10)


def test_navigate_to_sign_up_from_login():
    driver.get("https://benevolent-pegasus-249129.netlify.app/")
    sign_up_link = driver.find_element('id', 'sign-up-link')
    sign_up_link.click()
    sign_up_header = driver.find_element('id', 'sign-up-header')
    assert sign_up_header.text == 'Sign Up'

def test_sign_up_successful():
    fake = Faker()
    driver.get("https://benevolent-pegasus-249129.netlify.app/signup")
    email = driver.find_element('id', 'email')
    username = driver.find_element('id', 'username')
    first_name = driver.find_element('id', 'first-name')
    last_name = driver.find_element('id', 'last-name')
    password = driver.find_element('id', 'password')
    confirm_password = driver.find_element('id', 'confirm-password')
    submit_button = driver.find_element('id', 'sign-up-button')

    fake_password = fake.password()

    email.send_keys(fake.email())
    username.send_keys(fake.user_name())
    first_name.send_keys(fake.first_name())
    last_name.send_keys(fake.last_name())
    password.send_keys(fake_password)
    confirm_password.send_keys(fake_password)
    submit_button.click()

    login_header = driver.find_element('id', 'login-header')
    sign_up_success = driver.find_element('id', 'sign-up-success')

    assert login_header.is_displayed() == True
    assert sign_up_success.is_displayed() == True
    assert sign_up_success.text == 'Sign up successful, Log in now'
    driver.close()


