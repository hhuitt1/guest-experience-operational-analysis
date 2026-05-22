-- ====================================================
-- Guest Experience & Operational Performance Analysis
-- ====================================================

-- Query 1: Average Satisfaction by Park

SELECT 
    park,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
FROM guests
GROUP BY park
ORDER BY avg_satisfaction DESC;

-- Findings:
-- Animal Kingdom and Hollywood Studios reported the highest average
-- guest satisfaction levels, while Magic Kingdom demonstrated slightly
-- lower satisfaction trends that may indicate opportunities for
-- operational or guest experience improvements.


-- Query 2: Average Spend by Park

SELECT 
    park,
    ROUND(AVG(spend), 2) AS avg_guest_spend
FROM guests
GROUP BY park
ORDER BY avg_guest_spend DESC;

-- Findings:
-- Guest spending remained relatively strong across all parks, with
-- EPCOT leading average per-guest spending. This may reflect higher
-- engagement with dining, retail, and premium guest experiences.


-- Query 3: Average Wait Time by Park

SELECT 
    park,
    ROUND(AVG(wait_time), 2) AS avg_wait_time
FROM attractions
GROUP BY park
ORDER BY avg_wait_time DESC;

-- Findings:
-- Average attraction wait times remained relatively consistent across
-- all parks, with Magic Kingdom reporting the highest average queue
-- duration. This suggests that guest demand and attraction utilization
-- levels were broadly comparable throughout the resort.


-- Query 4: Attractions with Most Downtime 

SELECT 
    ride_name,
    park,
    SUM(downtime_minutes) AS total_downtime
FROM attractions
GROUP BY ride_name, park
ORDER BY total_downtime DESC;

-- Findings:
-- Slinky Dog Dash, Kilimanjaro Safaris, and Frozen Ever After
-- experienced the highest total downtime levels, indicating potential
-- operational reliability challenges for several high-demand attractions
-- across multiple parks.

-- Recommendation:
-- Operations leadership should prioritize preventive maintenance
-- scheduling and downtime reduction strategies for high-demand
-- attractions to improve throughput efficiency and minimize
-- guest disruption.


-- Query 5: Wait Time Impact on Satisfaction 

SELECT 
    g.park,
    ROUND(AVG(a.wait_time), 2) AS avg_wait_time,
    ROUND(AVG(g.satisfaction_score), 2) AS avg_satisfaction
FROM guests g
JOIN attractions a
    ON g.park = a.park
    AND g.visit_date = a.visit_date
GROUP BY g.park
ORDER BY avg_wait_time DESC;

-- Findings:
-- Higher attraction wait times did not consistently correspond with
-- lower guest satisfaction. This may indicate that strong attraction
-- demand and perceived experience value can offset guest frustration
-- associated with longer queues.

-- Recommendation:
-- Operations teams should continue prioritizing attraction throughput
-- and queue management strategies while enhancing the guest waiting
-- experience through entertainment, communication, and virtual queue
-- solutions for high-demand attractions.


-- Query 6: Staffing Call-Out Rate by Department 

SELECT
    department,
    SUM(call_outs) AS total_call_outs,
    SUM(staffing_level) AS total_scheduled_staff,
    ROUND((SUM(call_outs) * 100.0 / SUM(staffing_level)), 2) AS call_out_rate
FROM staffing
GROUP BY department
ORDER BY call_out_rate DESC;

-- Operational Insight:
-- Attractions and Custodial departments experienced the highest
-- employee call-out rates, while Entertainment maintained the
-- lowest rate despite having the highest staffing levels.

-- Recommendation:
-- Leadership should evaluate staffing contingency planning within
-- Attractions and Custodial departments to reduce operational
-- disruption during peak attendance periods.


-- Query 7: Complaint Volume by Type

SELECT
    complaint_type,
    COUNT(*) AS total_complaints
FROM complaints
GROUP BY complaint_type
ORDER BY total_complaints DESC;

-- Findings:
-- Guest complaints were most frequently associated with Staff
-- Interaction and Cleanliness issues, highlighting potential
-- opportunities to improve frontline service consistency and
-- operational maintenance standards.


-- Query 8: Average Complaint Resolution Time by Severity 

SELECT
    severity,
    ROUND(AVG(resolution_time), 2) AS avg_resolution_time
FROM complaints
GROUP BY severity
ORDER BY avg_resolution_time DESC;

-- Findings:
-- High severity complaints required significantly longer resolution
-- times compared to medium and low severity cases, indicating that
-- more complex guest issues demand greater operational resources
-- and service recovery efforts.