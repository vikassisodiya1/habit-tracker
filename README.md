# 🧠 Habit Tracker

A modern habit tracking app built with **Ruby on Rails**, **Hotwire**, and **Tailwind CSS**.

> ✅ **Rails Version**: `7.2.2.1`  
> ✅ **Ruby Version**: `3.1.0p0`  
> ✅ **Yarn Version**: `4.9.2`

---

Users can:

- Create, edit, and delete habits
- Mark habits as done for today or previous days
- View mini-calendar with check-in tracking
- Track streaks (current, longest) and consistency %
- Receive weekly email summaries via Sidekiq
- Authenticate via JWT (Devise)

---

## 🚀 Features

- 🔐 JWT Authentication with Devise
- 🎨 Tailwind CSS UI
- ⚡️ Hotwire (Turbo + Stimulus) for real-time updates
- 🗓 Mini-calendar UI per habit (color-coded)
- 📈 Habit stats (badges for streaks, completions)
- 📬 Weekly email summaries using ActionMailer + Sidekiq
- 💌 Dev email preview with Letter Opener Web

---

## 📦 Setup Instructions

### 1. Clone the repo

```bash
git clone https://github.com/vikassisodiya1/habit-tracker.git
cd habit-tracker
```

### 2. Install dependencies

```bash
bundle install
yarn install
```

### 3. Setup database

```bash
rails db:create db:migrate db:seed
```

### 4. Start Redis (for Sidekiq)

```bash
redis-server
```

### 5. Run the app

```bash
bin/dev
```