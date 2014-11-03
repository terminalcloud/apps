# **ErpNext** Terminal.com Snapshot
*Open Source ERP Built For The Web*

---

## About erpnext CRM
People who use ERPNext, swear by it. No fancy sales people, no glitzy presentations, but finally a software for SMBs that just works at prices that you can afford. Sample what our users are saying, "ERPNext has many innovative features that many more expensive ERP systems do not have."

ERPNext covers most functionality required to run a small or medium sized business in Manufacturing, Retail, Distribution or Services including Financial Accounting, Inventory, CRM and Sales, Purchasing, Human Resource, Projects and a lot more.

---


## Usage

Just spin-up your container based on this snapshot and click to "Test your installation here".
Login with your admin credentials and and configure your ERP based on your needs.


### Credentials:

- username: administrator
- password: t3rminal


### Additional Usage Information
Due security reasons, ERPNext is running under a non-privileged user called "bundle", by default in the second tab of your terminal command line. You can stop ERPNext by pressing 'control + c' and start it again running `cd frappe-bench bench; start` as the bundle user.

### Additional credentials
- User password for bundle: t3rminal
- MariaDB root password: root


---

## Documentation and links
- [ERPNext Official Website](https://erpnext.com/)
- [User's Manual](https://erpnext.com/user-guide)
- [Forums](https://discuss.frappe.io/)
- [Community Portal](https://frappe.io/community)
- [GitHub Repo](https://github.com/frappe/erpnext)

---

## Features Samples
- **Dashboard** - Here is a broad overview of how a small business making Wind Turbines uses ERPNext for running their operations right from setting up and implementation to day-to-day management-
![1](https://erpnext.com/assets/erpnext_org/images/features/feature-1.png)

- **Setting Up** -After setting up ERPNext by running through the Setup Wizard, Company and first few masters will be created. You can complete it by creating Items, Leads, Customers, Suppliers and Bill of Materials.
![2](https://erpnext.com/assets/erpnext_org/images/features/feature-2.png)

- **Selling** - Once your system is setup, you can keep track of communication with your Leads or Customers. You can send them Newsletters once in a while and send specific Quotations when they are ready to buy. When they place an order, you create a Sales Order.
![3](https://erpnext.com/assets/erpnext_org/images/features/feature-3.png)

- **Buying and Inventory** - You can setup your inventory warehouses and manage the stock of your Items Batchwise or by Serial Numbers. Keep track of Items to buy by raising Material Requests, send Purchase Orders to your Customers and enter Purchase Receipts when you receive material.
![4](https://erpnext.com/assets/erpnext_org/images/features/feature-4.png)

- **Manufacturing** - You can plan your production and material by the Production Planning Tool. Then transfer and convert your raw materials to finshed goods.
![5](https://erpnext.com/assets/erpnext_org/images/features/feature-5.png)

- **Billing and Payments** - Bill your customers and make shipment entries to keep track of Deliveries. Make payment vouchers for money spent and received.

- **Projects** - Define and allocate tasks for Projects and make Time Log entries for work done against tasks.
![6](https://erpnext.com/assets/erpnext_org/images/features/feature-6.png)

- **Customer Support** - Capture incoming emails with Support requests from your Customers and tag and allocate them to your team for resolutions. Keep track of service and maintenance contracts and schedules.
![7](https://erpnext.com/assets/erpnext_org/images/features/feature-7.png)

- **Leave, Expenses and Payroll** - With EPRNext you can manage Employee Leaves and manage and approve their Expense Claims. You can also generate monthly Payroll and integrate it with Accounting.
![8](https://erpnext.com/assets/erpnext_org/images/features/feature-8.png)

- **Retail Point of Sale** - If you have a retail outlet, you can setup a Point of Sale, where you can make the Bill, Payment and Inventory in once action.
![9](https://erpnext.com/assets/erpnext_org/images/features/feature-9.png)

- **Website and Shopping Cart** - You can also generate a fully functional and styled website with your product catalog and shopping cart updated from within your Item master.
![10](https://erpnext.com/assets/erpnext_org/images/features/feature-10.png)


---

### Additional Information

#### erpnext CRM Terminal.com container semi-automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/erpnext_installer.sh && bash erpnext_installer.sh show`

---

#### Thanks for using erpnext CRM at Terminal.com!
