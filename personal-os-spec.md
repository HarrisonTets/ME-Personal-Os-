# Personal Improvement App – Product & Technical Specification

## 1. Product Overview

**Working name:**  
ME (Personal OS)

**Summary:**  
A Flutter mobile app that acts as a personal growth companion across five pillars:

1. Finances  
2. Learning & research  
3. Spiritual life (Bible-focused)  
4. Focus & decision fatigue  
5. Health & fitness  

The app learns from user behavior and reflections, then suggests a small number of high‑leverage actions each day instead of overwhelming the user with options.

---

## 2. Target Users and Personas

### 2.1 Primary persona – "Busy Builder"

- Full‑stack developer and entrepreneur juggling multiple projects.  
- Pain points: context switching, inconsistent habits, money leakage, feeling spiritually dry or unfocused, decision fatigue, and neglecting health while working intensely.  
- Devices: Android first, iOS soon after.

### 2.2 Secondary persona – "Ambitious Professional"

- Age 25–40, works in tech, business, or creative field.  
- Wants better financial discipline, structured learning, deeper spiritual or personal life, and sustainable health habits.

---

## 3. Goals and Success Metrics

### 3.1 Product goals

- Help users:
  - Build consistent habits in finances, learning, spirituality, focus, and health.
  - Reduce decision fatigue by offering a curated set of daily actions.
  - Reflect regularly and grow self‑awareness about needs, energy, and limits.
  - Maintain a healthier body and routine without needing a separate fitness app.

### 3.2 Success metrics

- Weekly active users and day‑7 retention.[web:11][web:20]  
- Average number of completed daily actions per user (across all pillars).  
- Streak length for key habits (Bible reading, expense logging, learning sessions, workout completion, hydration, sleep consistency).[web:16][web:19]  
- Self‑reported satisfaction scores (e.g., weekly "How aligned did you feel this week?").

---

## 4. Scope and Non‑Goals

### 4.1 In scope (MVP + v1)

- Mobile app built with Flutter for Android and iOS.  
- Local-first data (offline capable), with later option to sync via Supabase/Firebase.  
- Five main pillars plus a central "Today" screen.  
- Clean Architecture style layering (Presentation / Domain / Data) so business logic is independent of UI and data sources.[web:12][web:21][web:24]  
- Lightweight health and fitness tracking focused on consistency rather than advanced medical analytics.

### 4.2 Explicit non‑goals (for now)

- Full banking integration or automatic bank scraping.  
- Multi-user or shared accounts.  
- Advanced ML/AI personalization (start with rule‑based logic).  
- Full medical diagnostics or replacement for a healthcare app.  
- Web/desktop clients.

---

## 5. Core Concepts and Pillars

### 5.1 Pillars

Each pillar represents a domain of growth:

- Finance  
- Learning & research  
- Spiritual/Bible  
- Focus & decision fatigue  
- Health & fitness  

Each pillar has:

- Goals  
- Habits/routines  
- Logs and history  
- Pillar "health score" (0–100) based on consistency and reflections.

### 5.2 Growth engine (cross‑pillar)

Common system linking all pillars:

- **Goals** – concrete targets (e.g., save a certain amount, finish a reading plan, complete weekly workouts).  
- **Habits** – recurring actions linked to pillars and/or goals.  
- **Daily suggestions** – small set of actions chosen per day.  
- **Reflections** – daily/weekly check‑ins feeding personalization.  
- **Pillar scores** – used by suggestion engine to prioritize.  
- **Energy awareness** – health, sleep, and mood data influence what type of tasks are suggested across all pillars.

---

## 6. Detailed Feature Requirements

### 6.1 Core / Growth Engine

#### 6.1.1 Onboarding

Ask the user:

- Which pillars they want to focus on (can select multiple).  
- High‑level struggles (checkboxes, e.g., "overspending", "inconsistent Bible reading", "easily distracted", "not exercising consistently", "poor sleep routine").  
- Available time slots (morning, afternoon, evening).  
- Intensity of reminders (low/medium/high).  
- Health priorities such as walking more, drinking water, sleeping earlier, stretching, or training consistently.

System behavior:

- Create initial default habits per pillar (e.g., "Log yesterday’s expenses", "Read one chapter", "15‑min learning session", "10‑min walk", "Drink water").  
- Set an initial daily action budget (e.g., max 3–5 suggestions/day).

#### 6.1.2 Today Screen (Home)

- Single home screen listing **3–5 suggested actions** grouped by pillar, for example:  
  - Finance: "Log yesterday’s expenses (5 min)"  
  - Learning: "Study Flutter animations – 15 min"  
  - Spiritual: "Read John 1 & reflect – 10 min"  
  - Focus: "Start 25‑min deep work session for Project X"  
  - Health: "Take a 10‑minute walk and drink water"  
- Each suggestion includes:  
  - Pillar label and icon.  
  - Estimated time.  
  - One‑tap "Start" or "Mark done" action.  

Suggestion generation:

- Run once per day (and on user request) based on:  
  - Pillar scores (prioritize weaker pillars).  
  - Habit streaks (protect streaks, revive near‑broken ones).  
  - User’s time windows and past completion patterns.  
  - Daily action budget (avoid overloading the user).  
  - Recent energy, sleep, and wellness indicators from the health pillar.

#### 6.1.3 Habits and Goals

Habits:

- Properties: name, description, pillar, optional linked goal, schedule (daily, specific weekdays, weekly, custom), difficulty (light/medium/deep), active flag.  
- Tracked via HabitLogs (date, status, mood, notes).

Goals:

- Properties: pillar, title, optional numeric target (e.g., amount, number of chapters, hours, liters of water, workout frequency), optional due date, description.  
- Progress derived from linked habits and logs (e.g., number of readings completed, total money saved, total learning hours, total workouts completed).

#### 6.1.4 Reflections

Daily reflection (evening):

- Prompts:  
  - Mood scale (low / medium / high).  
  - Energy scale (low / medium / high).  
  - "What drained you today?" (selection from tags and optional text).  
  - "What energized you?"  
  - Optional pillar tag (finance / learning / spiritual / focus / health / other).  

Weekly reflection:

- Show weekly summary:  
  - Streaks and completed tasks.  
  - Time spent in focus and learning.  
  - Bible reading progress, simple finance overview, and health consistency.  
- Prompts:  
  - "How aligned did you feel this week?" (scale).  
  - "How did your body feel this week?" (scale or short text).  
  - "One thing you want to change next week" (short text).  

Reflections feed into pillar scores and suggestion weights.

#### 6.1.5 Notifications

Types:

- Morning "Today" summary (optional toggle).  
- Habit reminders based on schedule (capped per day to avoid spam).  
- Reflection prompts (daily and weekly).  
- Health nudges such as hydration, walking, stretching, sleep wind‑down, or workout reminders.

Smart behavior:

- Avoid stacking too many notifications in one time block.  
- If a type of notification is consistently ignored, gradually reduce its frequency.  
- Respect user’s chosen reminder intensity.

---

### 6.2 Finance Module

#### 6.2.1 Basic Finance Model

User can record:

- Type: income or expense.  
- Amount and currency.  
- Category: e.g., food, rent, transport, giving, business, other.  
- Date/time (default to now).  
- Optional note.  

All data is stored locally first; later sync can be added behind repository interfaces.

#### 6.2.2 Finance Views

1. **Quick Add Panel**  
   - Accessible from Today screen and Finance home.  
   - Minimal fields: amount, category, and date (default today).  
   - One‑tap save.

2. **Finance Home**  
   - "This week" card: total spent, total income (optional), number of entries.  
   - "Big picture" card: monthly totals, simple bar chart of categories.  
   - List of recent entries with filters (date range, category).

3. **Analytics (v1)**  
   - Weekly and monthly summary:  
     - Total income vs expenses.  
     - Top 3 spending categories.  
   - Simple, clean visuals for quick understanding.[web:13][web:22][web:25]

#### 6.2.3 Finance Habits and Suggestions

Default habits:

- "Log yesterday’s expenses" daily.  
- Optional "Review weekly spending" on a chosen day (e.g., Sunday).

Suggestion rules:

- If user hasn’t logged anything in 2+ days: suggest logging missed days.  
- If a category spikes compared to usual: suggest a reflection like "Review your food spending this week".  
- Health and finance can intersect through optional wellness spending insights (e.g., gym, groceries, supplements) without becoming a full budgeting coach.

---

### 6.3 Learning & Research Module

#### 6.3.1 Core Concepts

- **Topic** – high‑level area (e.g., Flutter, Investments, Leadership, Bible theology).  
- **Resource** – learning material tied to a topic (link, book, video, PDF).  
- **Learning session** – a focused block of study time.

#### 6.3.2 Learning Views

1. **Topics List**  
   - Cards with: title, short description, total hours spent, current streak or status.

2. **Topic Detail**  
   - List of resources with status (not started / in progress / done).  
   - "Start 15‑min session" button picks next resource based on status and priority.  
   - Notes and insights list for that topic.

3. **Session Flow**  
   - Start session → show current resource with timer or indication of focus.  
   - After session:  
     - Prompt for 3 key takeaways.  
     - Allow creating "insight cards" linked to other pillars (e.g., how a concept relates to business, spiritual life, or health).

#### 6.3.3 Learning Habits and Suggestions

Default habits:

- "15‑min learning session" daily or a set number of times per week.  

Suggestion rules:

- Prioritize partially completed topics over starting new ones.  
- On low‑energy days (from reflections), prefer light learning tasks or skip heavy sessions.  
- On high‑energy days, suggest deeper learning blocks or chaining sessions.

---

### 6.4 Spiritual / Bible Module

#### 6.4.1 Bible Reading Plans

Built‑in plans (examples):

- "Gospels in 60 days".  
- "Psalms & Proverbs rotation".  
- "Whole Bible" long‑term plan.  

Each plan:

- Has daily reading assignments (book, chapter range).  
- Tracks completion, progress, and streak.

#### 6.4.2 Quiet Time Flow

- Daily "Quiet Time" card shows today’s reading passage.  
- Start button enters immersive reading mode (full screen, minimal UI).  
- After reading:  
  - Reflection prompt (e.g., "What stood out?", "How does this apply today?").  
  - Optional prayer or journal entry.  

Journal:

- Timeline of entries.  
- Filterable by reading plan, passage reference, or tags (e.g., faith, money, calling, health).

#### 6.4.3 Spiritual Habits and Suggestions

Default habits:

- "Read plan assignment" daily.  
- "Write one sentence reflection" daily.  

Suggestion rules:

- If Bible reading streak is high: suggest deeper optional reading or additional reflection.  
- If streak breaks: send gentle, encouraging nudge instead of guilt‑based tone.  
- If user indicates spiritual dryness in reflections: suggest shorter, more focused readings and reflection prompts.

---

### 6.5 Focus & Decision Fatigue Module

#### 6.5.1 Focus Sessions

Focus modes:

- Standard deep work sessions (e.g., 25 min focus + 5 min break).  
- Custom durations (user-defined).  

Each session:

- Requires an "intention" or task description (e.g., "Ship feature X", "Read Romans 8").  
- Captures start & end time, completion status, optional distraction notes.  

Focus history:

- Daily and weekly summary of:  
  - Number of sessions.  
  - Total focused minutes.  
  - Sessions grouped by pillar or tag.

#### 6.5.2 Decision Presets and Routines

Routines:

- Example: "Standard morning" routine containing:  
  - Bible reading.  
  - Quick finance check.  
  - One focus session for priority project.  
  - Water intake or a short stretch.  
- Example: "Deep work day" vs "Light day" routines.  

User capabilities:

- Create, edit, and delete routines.  
- Define sequence of actions across pillars for each routine.  
- Tag routines with recommended days and energy levels (low/medium/high).  

Behavior:

- On low‑energy days (from reflections), app suggests a "light" routine.  
- On high‑energy days, app suggests a "deep work" or more demanding routine.

#### 6.5.3 Focus Habits and Suggestions

Default habits:

- "Do 1 deep focus session" per day.  
- Optional weekly "Plan your week" session.

Suggestion rules:

- Prioritize at least one focus session tied to the user’s most important pillar or goal.  
- Suggest weekly review and routine planning on a chosen day.  
- Use health indicators such as poor sleep or low energy to reduce demanding cognitive suggestions when needed.

---

### 6.6 Health & Fitness Module

#### 6.6.1 Core Purpose

The health and fitness module exists to help the user care for their body in a simple, sustainable way without turning the app into a complicated fitness platform. The focus is on consistency, recovery, energy, movement, hydration, sleep, and realistic routines.

#### 6.6.2 Health Views

1. **Health Home**  
   - Today’s wellness summary: water, sleep, movement, workout, and energy.  
   - Quick actions: log water, mark walk done, start stretch, log workout, log sleep.

2. **Workout & Movement View**  
   - Track simple workout sessions: walking, running, gym, bodyweight, stretching, sports.  
   - Record duration, intensity, and notes.  
   - Show weekly target progress (e.g., 3 workouts this week).

3. **Sleep & Recovery View**  
   - Log sleep start/end times or hours slept.  
   - Optional rating for sleep quality.  
   - Show simple trend like average bedtime or average sleep duration.

4. **Hydration & Daily Wellness View**  
   - Quick logging for water intake.  
   - Optional simple wellness habits: vitamins, stretching, standing up, breathing session, step target.

#### 6.6.3 Health Habits and Goals

Examples of habits:

- Drink water 3–5 times per day.  
- Walk 10–20 minutes daily.  
- Complete 3 workouts per week.  
- Sleep before a chosen time.  
- Stretch after long work sessions.

Examples of goals:

- Complete 12 workouts this month.  
- Average at least 7 hours of sleep.  
- Walk at least 5 days each week.  
- Build a consistent morning or evening wellness routine.

#### 6.6.4 Health Suggestions and Personalization

Suggestion rules:

- If user reports low energy, suggest recovery-focused actions such as stretching, walking, hydration, or an earlier wind‑down.  
- If focus completion drops and sleep is poor, suggest sleep recovery or lighter routines the next day.  
- If sedentary patterns are detected through habit completion gaps, suggest short movement breaks.  
- If workout streak is strong, suggest progression carefully without overwhelming the user.

The health pillar should also influence the rest of the app by helping the system understand whether the user needs a challenge day, a normal day, or a recovery day.

---

### 6.7 Profile, Settings, and Personalization

#### 6.7.1 Profile

- Basic info: name, preferred language, timezone.  
- Pillars enabled / disabled.  
- Optional "life theme" or motto displayed in the app.  
- Optional health preferences such as workout style, preferred active hours, and water goal.

#### 6.7.2 Settings

- Reminder intensity and preferred time windows.  
- Maximum number of daily suggestions.  
- Privacy options: analytics toggles, biometric lock, backup preferences.  
- Optional toggles for wellness reminders such as hydration, movement, and sleep.

#### 6.7.3 Personalization Logic (High Level)

Pillar scoring:

- Each pillar has a score influenced by:  
  - Habit completion rate.  
  - Goal progress.  
  - Reflections tagged with that pillar (positive vs negative sentiment).  
  - For health: sleep consistency, workout consistency, hydration/movement completion, and energy patterns.

Suggestion ranking:

- Lower‑score pillars get higher priority.  
- Avoid scheduling too many "deep" tasks in one day.  
- Learn user’s successful times from historical completion data, and favor those.  
- Use health and recovery signals to determine whether the day should be light, balanced, or intense.

This is rule‑based logic implemented in the domain layer, inspired by habit‑tracking and analytics best practices.[web:13][web:16][web:19][web:22]

---

## 7. User Stories (Selected)

### 7.1 Core

- As a user, I want to see a small list of important actions each day so I don’t have to decide from scratch what to do.  
- As a user, I want the app to consider my energy, time, and past behavior when suggesting actions so that it doesn’t overwhelm me.  

### 7.2 Finance

- As a user, I want to quickly log expenses in a few taps so I can maintain a log without friction.  
- As a user, I want to see where my money went this week/month so I can adjust my spending.  

### 7.3 Learning

- As a user, I want to define topics and resources so I can study in a structured way.  
- As a user, I want the app to remind me to do a short learning session so my growth is consistent.  

### 7.4 Spiritual

- As a user, I want a Bible reading plan with daily portions so I don’t have to decide where to read each day.  
- As a user, I want to write short reflections after reading so I can track my spiritual journey.  

### 7.5 Focus & Decision Fatigue

- As a user, I want to start a focused work session with a clear intention so I can protect my attention.  
- As a user, I want pre‑defined routines (e.g., morning, deep work day) so I can reduce daily decisions.  

### 7.6 Health & Fitness

- As a user, I want simple health tracking that fits naturally into my day so I can stay consistent without using a separate app.  
- As a user, I want the app to factor in my sleep, energy, and movement when suggesting tasks so my daily plan matches my real condition.  
- As a user, I want small workout, walking, hydration, and stretching goals so I can improve my physical wellbeing steadily.

---

## 8. Key User Flows (Described)

### 8.1 Daily Usage Flow

1. User opens the app in the morning.  
2. Today screen shows 3–5 suggested actions across pillars.  
3. User selects one suggestion:  
   - Bible: enter Quiet Time flow, complete reading, write a brief reflection, return to Today.  
   - Finance: open Quick Add, log expenses, return.  
   - Focus: start a focus session; after completion, mark it done.  
   - Health: log water, start a walk, mark a stretch or workout complete, or log sleep.  
4. Throughout the day, notifications remind the user of remaining actions within set limits.  
5. In the evening, the app prompts for daily reflection.

### 8.2 Weekly Review Flow

1. On a chosen day (e.g., Sunday), the app shows a summary:  
   - Completed habits, streaks.  
   - Time spent on focus and learning.  
   - Bible reading progress.  
   - Finance overview.  
   - Health overview (sleep, workouts, movement, hydration consistency).  
2. User answers reflection questions and optionally adjusts goals.  
3. The app recalculates pillar scores and adapts suggestion patterns for the coming week.

---

## 9. Information Architecture (Screens)

- Today (Home)  
- Pillars overview (optional, or integrated into Today)  
- Finance:  
  - Finance home  
  - Add/edit entry  
  - Analytics view  
- Learning:  
  - Topics list  
  - Topic detail  
  - Session screen  
- Spiritual:  
  - Plan selection  
  - Today’s reading / Quiet Time  
  - Journal list and entry detail  
- Focus:  
  - Focus home (start session)  
  - Focus history  
- Health:  
  - Health home  
  - Workout & movement view  
  - Sleep & recovery view  
  - Hydration & wellness view  
- Reflections:  
  - Daily reflection screen  
  - Weekly review screen  
  - Reflection history  
- Profile & Settings

---

## 10. Data Model (Described, Not in Code)

Entities and relationships are described conceptually so they can be implemented in any persistence layer.

- **UserProfile**  
  - One per app install (or per account when sync is added).  
  - Has many Pillars, Goals, Habits, Reflections.

- **Pillar**  
  - Attributes: type, enabled flag, score.  
  - Has many Goals, Habits, Logs (Finance entries, Focus sessions, Health logs, etc.).

- **Goal**  
  - Belongs to one Pillar.  
  - Optionally linked to multiple Habits.

- **Habit**  
  - Belongs to one Pillar.  
  - Can be linked to one Goal.  
  - Has many HabitLogs.

- **HabitLog**  
  - Belongs to one Habit.  
  - Contains date, status, mood, notes.

Module‑specific entities:

- **FinanceEntry**  
  - Belongs to Pillar (finance) and optionally to a Goal (e.g., "Emergency fund").

- **Topic, LearningResource, LearningSession**  
  - Topic has many LearningResources and LearningSessions.  

- **BiblePlan, BibleReadingAssignment, JournalEntry**  
  - BiblePlan has many BibleReadingAssignments (daily passages).  
  - JournalEntry can reference a BiblePlan and specific passages.

- **FocusSession**  
  - Belongs to a Pillar or Goal (optional).  
  - Stores intention, duration, and result.

- **HealthLog**  
  - Stores wellness data such as workout type, duration, sleep, hydration, movement, recovery notes, and energy.  
  - Can be split internally into WorkoutLog, SleepLog, HydrationLog, and WellnessCheck if the implementer prefers a more structured model.

This level of description is sufficient for designing concrete tables or models.

---

## 11. Technical Architecture (Flutter, Described)

Use a **Clean Architecture** approach with three primary application layers (plus optional Core), as recommended in modern Flutter architecture guides.[web:12][web:15][web:18][web:21][web:24]

### 11.1 Presentation Layer

Responsibilities:

- Handle UI and user interaction.  
- Define screens, navigation, and state management.

Content:

- Screens for each feature: Today, Finance, Learning, Spiritual, Focus, Health, Reflections, Settings.  
- Widgets and reusable components (cards, lists, metrics, dialogs).  
- State management using a modern approach (e.g., Riverpod or BLoC) to connect UI to domain use cases.[web:18][web:21]

### 11.2 Domain Layer

Responsibilities:

- Contain business rules independent of Flutter or storage mechanisms.

Content:

- Entities: Habit, Goal, Pillar, FinanceEntry, Topic, LearningResource, BiblePlan, FocusSession, HealthLog, etc.  
- Use cases:  
  - GenerateTodaySuggestions  
  - LogFinanceEntry  
  - CompleteBibleReading  
  - StartFocusSession / CompleteFocusSession  
  - RecordDailyReflection  
  - LogWorkout / LogSleep / LogHydration  
  - DetermineRecoveryState  
- Abstract repository interfaces:  
  - FinanceRepository, LearningRepository, SpiritualRepository, FocusRepository, HealthRepository, ProfileRepository.

### 11.3 Data Layer

Responsibilities:

- Manage actual data storage and external integrations.

Content:

- Data sources:  
  - Local storage (e.g., local database or key‑value store).  
  - Future remote data sources (Supabase/Firebase).  
- Models for serialization/deserialization.  
- Repository implementations fulfilling the domain repository interfaces.

### 11.4 Core/Common Layer (Optional)

Responsibilities and content:

- Shared utilities:  
  - Error types and result wrappers.  
  - Date/time helpers, ID generation.  
  - Logging and configuration.  
  - Shared scoring logic for daily suggestions.

This structure keeps the app modular, testable, and scalable.[web:12][web:15][web:21][web:24]

---

## 12. Non‑Functional Requirements

### 12.1 Performance

- App should open quickly on mid‑range Android devices.  
- Today screen should render fast even with large history data.  
- Heavy computations (analytics) should be pre‑computed or cached where possible.

### 12.2 Offline Behavior

- All core operations (logging expenses, marking readings, focus sessions, reflections, health tracking) must work offline.  
- Sync and backup can be added later via remote repositories.

### 12.3 Security & Privacy

- Optional biometric/app lock for sensitive data.  
- No third‑party analytics by default; if added, user must opt in.  
- Sensitive data (journal, finances, wellness data) remains local unless user explicitly enables cloud backup.

### 12.4 Accessibility

- Respect system text scaling and accessibility settings.  
- Maintain high contrast and reasonable font sizes.  
- Avoid relying solely on color to indicate status.

---

## 13. Roadmap / Phases

### Phase 1 – Core + Spiritual + Basic Health

- Onboarding.  
- Today screen.  
- Goals/Habits core system.  
- Bible module (plans, Quiet Time, journal).  
- Daily reflection.  
- Basic health tracking: water, walking, sleep, and simple wellness habits.

### Phase 2 – Finance + Focus + Expanded Health

- Finance logging and basic weekly/monthly summary.  
- Focus sessions and simple routines.  
- Workout tracking and recovery-aware suggestion logic.  
- Integration of these into the suggestion engine.

### Phase 3 – Learning + Advanced Personalization

- Topics, resources, learning sessions, and notes.  
- Smarter suggestion logic combining all pillars and reflection patterns.  
- Optional cloud sync and backup.
