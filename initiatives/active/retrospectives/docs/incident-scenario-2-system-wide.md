  ✓ Fetched: SCENARIO 2 - Incident with system-wide impact
**Version Control -** Current Version - 1.0 / Release Date -

* * *

**Table of Contents**

13falsecirclelisttrue

* * *

# Incident with system-wide impact

**Incidents with System-wide Impact -** 1 or more region(s) partially (>1 tenant) or fully affected or the potential to escalate to these proportions. This causes an impact on developers and/or end-users.

## Incident Recovery

For incidents **reported by Customers**, Global Support will be accountable for managing the entire incident lifecycle, by logging, categorizing, prioritizing, and performing initial diagnosis.

If the resolution is not identified during the initial diagnosis stage, Global Support must escalate to Engineering.Typically, all **Severity 1** and some **Severity 2** incidents will be automatically escalated to the **SRE Team** due to the **high risk** of system-wide impact.

### Initial Troubleshooting

A Rootly incident and a **Slack Channel** will be automatically created and the SRE Team will immediately start troubleshooting.

In this scenario, the SRE Team will take the role of **Incident Commander** and **will swarm with any Development Team** to help move forward with incident troubleshooting, by adding the Team members to the Slack Channel.

A **Jira incident** will also be created and must be used by the Development Teams to log any decision and relevant information.

:arrows\_counterclockwise:1f504🔄#B3F5FF

**AUTOMATIC TASK \- Team Assignment**

The SRE Team will be assigned to a Jira Incident, through the field _Teams._

:arrows\_counterclockwise:1f504🔄#B3F5FF

**AUTOMATIC TASK \- Status Progression**

The Incident will be moved from TEam Assigned to TROUBLESHOOTING in ProgressBlue

**ALL COMMUNICATIONS** must be kept within the Slack Channel created automatically and any relevant decisions and information reported on the Incident Jira Ticket.

### Incident Declaration

Based on the initial impact assessment, the SRE Team will trigger the **incident declaration** process.

If the SRE team **denies** the system-wide impact, they will hand over the incident to the Development Team owning the error code/product area of the reported symptom. The Team will continue to work on the incident in Jira.

SCENARIO 1 - Incident without system-wide impact:arrows\_counterclockwise:1f504🔄#B3F5FF

**AUTOMATIC TASK \- Team Assignment**

The Development Team will be assigned to a Jira Incident, through the field _Teams_ and the incident will be displayed in the Development Teams backlog.

If the SRE Team **confirms** the system-wide impact of the incident, an event will be logged on the Slack Channel and trigger a communication motion to important stakeholders. A Communication Lead will be assigned to the incident.

### How to engage with Global Support?

When the incident is declared by the SRE Team **with system-wide impact**, the SRE Team will handle communication with Global Support. Development Teams will be consulted to align on what to communicate and ask for.

### Recovery Measures

The primary goal during an incident is to **minimize customer impact** as quickly as possible. This means focusing on restoring service, not on fixing the underlying problem.

With that in mind, your first step should always be to figure out what options you have to mitigate the problem as fast as possible:



Read more about rollback operations here: Change Management Process.

The**Change Management**process can be triggered as a recovery mechanism. If the SRE Team involvement is needed, you must create the corresponding Requests for Change and assign them to the `SRE Global` team.

:raised\_back\_of\_hand:1f91a🤚#B3F5FF

**MANUAL TASK \- Create Change Management Artifacts**

- Standard Request for Change \- [\[Form\]](https://outsystemsrd.atlassian.net/jira/software/c/projects/RFC/forms/form/direct/6/12582)

- Normal Request for Change \- [\[Form\]](https://outsystemsrd.atlassian.net/jira/software/c/projects/RFC/forms/form/direct/2/12523)

- Emergency Request for Change \- [\[Form\]](https://outsystemsrd.atlassian.net/jira/software/c/projects/RFC/forms/form/direct/3/12524)


:raised\_back\_of\_hand:1f91a🤚#B3F5FF

**MANUAL TASK \- Assign a Change to the SRE Team**

To trigger the SRE Team, you must add the `SRE Global` to the field _Teams_ on the Change Management artifacts created.

#### Traceability of Recovery Measures

Recovery measures must be linked to the RDINC Jira issue using the **Linked Issues** Jira capability _“is blocked by”_.

Additionally, other recovery measures such as bugs can be reported and used as a recovery mechanism, if included on the SDLC pipeline and propagated through the rings.

When the SRE Team confirms the symptoms are no longer manifesting, the SRE Team will mark the incident as Resolved.

:arrows\_counterclockwise:1f504🔄#B3F5FF

**AUTOMATIC TASK \- Status Progression**

The Incident will be moved from TROUBLESHOOTING in ProgressBlue to solvedGreen

## Moving to the Retrospective Stage

For incidents **with system-wide impact**, the Retrospective stage **is mandatory**. This stage can be initiated following the guidelines below.

V2 - Retrospective Process
