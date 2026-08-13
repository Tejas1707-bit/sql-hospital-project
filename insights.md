# Key Insights — Hospital Network Data Analysis

Dataset: 100 hospital-department records across 10 hospitals and 10 cities in India.

## Volume
- The network treated **9,347 patients** in total across all hospitals and departments.
- **Jaipur (1,505 patients)** and **Ahmedabad (1,467 patients)** are the highest-volume cities; **Delhi (421)** and **Mumbai (483)** are the lowest — a 3.5x spread that suggests uneven regional demand or capacity.
- **Urology, Neurology, and ENT** are the top 3 departments by patient volume, together handling over 4,000 patients — these should be the priority for staffing and resource allocation.
- **Cardiology** has the lowest total patient volume (544 patients) despite Cardiology and Pediatrics showing the *longest* average stays — a signal that Cardiology cases are lower-frequency but more resource-intensive per case.

## Cost
- **Healing Touch** hospital recorded the highest total medical expenses (**₹352,178.06**).
- Monthly expense trend shows no single runaway month — spend fluctuates between **~₹98K (April)** and **~₹347K (December)**.

## Data Quality (a finding in itself)
- **26 of the 100 records (26%) have a Discharge Date earlier than the Admission Date** — almost certainly a data-entry error in the source system, not a real event.
- Left unhandled, this silently breaks any stay-length or per-day-cost calculation: e.g. the raw "average expense per day" query ranks **City Hospital and Heritage Hospital** at the top, purely because their total stay-days went negative and inflated the ratio — not because they're actually the most expensive per day of care.
- After excluding these rows, the more trustworthy read is:
  - **Fortis Care** has the highest genuine average expense per patient-day (~₹1,081/day).
  - **General Medicine** has the longest average valid stay (~107 days), not Cardiology as the raw/unfiltered numbers suggested.
- **Takeaway:** roughly a quarter of this dataset would have produced misleading conclusions if used as-is — flagging and excluding bad rows changed which hospital and which department looked most cost-intensive.
