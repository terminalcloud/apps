# **GLPI** Terminal.com Snapshot
*Free IT and Asset Management Software*

---

## About GLPI
**GLPI** is the Information Resource-Manager with an additional Administration- Interface. You can use it to build up a database with an inventory for your company (computer, software, printers...). It has enhanced functions to make the daily life for the administrators easier, like a job-tracking-system with mail-notification and methods to build a database with basic information about your network-topology.

### Features
- **General**
  - Multi-entities management (multi-park, multi-structure)
  - Multi-users management
  - Multiple Authentication System (local, LDAP, AD, Pop/Imap, CAS, x509...) and multiple servers
  - Multilingual management (45 languages available )
  - Permissions and profiles system
  - Pagination system
  - Complex search module
  - Bookmark search system
  - Publishing system for public or personal reminders
  - Publishing system for public or personal RSS feeds
  - Configurability of display fields in lists
  - Export System in PDF, CSV, SLK (spreadsheet), PNG and SVG
  - Saving/restoration module of the database to the SQL format
  - Exportation of the database to the XML format
  - Configurable dropdowns
  - Dictionary
  - System of notifications on events (consumable stock, expiry of contracts and licenses), customizable and by entity
  - Customizable cron tasks
  - Updates check system
  - UTF8 interface
  - HTML 4.01 compatibility

- **Inventory**
  - Import inventory’s datas from OCS Inventory NG servers with the plugin OCS Inventory NG
  - Import inventory’s datas from FusionInventory agents with the plugin FusionInventory
  - Inventory of the computers fleet with management of its components, disk space and TCO management
  - Inventory of the monitors with management of the connections to the computers
  - Inventory of the network hardware fleet with management of the connections to the devices (IP, Mac addresses, VLANs...).
  - Inventory of printers fleet with management of connections to the computers and management of consumable associated and consumption and the thresholds of   alarm.
  - Inventory of the external devices (scanners, graphical tables...) with management of the connections to the computers - Inventory of the telephones fleet with  management of connections to the computers
  - Inventory if the software fleet with license and expiration dates management
  - Assignment of the hardware by geographic area (room, floor...)
  - Typing models management to make the insertion of equal configurations easier
  - Administrative and financial Information management (purchase, guarantee and extension, damping)
  - Filing of the materials left the inventory
  - Management of the status of the hardwares
  - Management of the various states for the materials (in repair...) - Management of generic peripherals and monitors being able to be associated several  computers
  - Management of external bonds towards other applications
  - History of the modifications on the elements of the inventory’s

- **Service Desk - ITIL**
  - Management of the tracking requests for all the types of material of the inventory
  - Management of recurrent tracking requests for regular maintenance
  - Management of problems
  - Tracking requests opened using web interface or email
  - Business rules when opening tickets (customizable by entity)
  - SLA with escalation (customizable by entity)

  - Final user

    - Final user front-end for intervention demand
    - Mail tracking of the intervention demand feature
    - Interventions history consultation
    - Possibility of adding comments at the request of intervention using web interface or email
    - Approval of the solution
    - Satisfaction survey

  - Technicians

    - Interventions demands priority management
    - Interventions demands templates with management of hidden, mandatory and predefined fields
    - Tracking of interventions demands
    - Link between interventions demands management
    - Mail tracking of interventions
    - Request validation
    - Assignment of interventions demands
    - Opening/Closing/Re-opening of interventions
    - Assignment of a real time of interventions
    - History of done interventions
    - Displaying of the interventions to do by a technician
    - Displaying of the history of the interventions for a given hardware
    - Posting of the interventions to be realized by technician
    - Check availability of technicians before assignment of an intervention
    - Posting of the history of the interventions for a given material
    - Management of planning of intervention
    - Define the solution

- **Statistics**
Statistics reports by month, year, total in PNG, SVG or CSV.
  - Global
  - By technician or enterprise
  - By hardware, location or type
  - By user
  - By category
  - By priority


---


## Usage

Just spin-up your container based on this snapshot and click over "Check your application here".
Login with your admin credentials and start using GLPI.


### Credentials:

**Default logins / passwords are:**

- glpi/glpi for the administrator account
- tech/tech for the technician account
- normal/normal for the normal account
- post-only/postonly for the postonly account

*You can delete or modify these accounts as well as the initial sample data.*

---

![1](http://www.glpi-project.org/IMG/png/computer1.png)

---

## Documentation
- [GLPI Official Website](http://www.glpi-project.org/spip.php?lang=en)
- [GLPI Documentation](http://www.glpi-project.org/spip.php?rubrique18)
- [GLPI Forum ](http://www.glpi-project.org/forum/)
- [Video and Screencasts](http://www.glpi-project.org/spip.php?rubrique85)

---


### Additional Information
#### GLPI Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/glpi_installer.sh && bash glpi_installer.sh`


---

#### Thanks for using GLPI at Terminal.com!