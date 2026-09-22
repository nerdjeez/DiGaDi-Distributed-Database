-- ==========================================
-- NODE 1: POSTGRESQL SEED DATA
-- ==========================================

COPY public.developers (dev_id, name, website) FROM stdin;
1	ConcernedApe	www.stardewvalley.net
2	Rockstar	www.rockstarsgame.com
3	Valve	www.example.com
4	Fromsoftware	www.example.com
6	Nusantara Games	https://nusantara.games
7	Global Arts	https://globalarts.com
5	Toby Fox	www.example.com
\.

COPY public.users (user_id, username, email, password, country, role, created_at) FROM stdin;
2	YandereDev	cumcalice@indie.studio	pass123	USA	developer	2026-05-16 01:19:03.205567
3	AdminJoko	joko@distro.com	pass123	Indonesia	admin	2026-05-16 01:19:03.205567
1	GamerIndo666	gayming@gmail.com	pass123	Indonesia	player	2026-05-16 01:19:03.205567
4	Faziz	fariz.speed333@gmail.com	pass123	Indonesia	player	2026-02-08 21:51:21.317901
5	Big E	jeevacation@gmail.com	pass123	USA	player	2026-02-08 21:51:21.317901
6	ProPlayer99	pro@gaming.com	pass123	USA	player	2026-02-08 21:51:21.317901
7	GabenNewellKw	gaben@valvesoftware.com	steamsale	USA	developer	2026-02-09 20:58:19.125182
8	TobyDog	toby@deltarune.com	annoyingdog	USA	developer	2026-02-09 20:58:19.125182
9	ArthurMorganStan	cowboy@western.com	huntin them rats	USA	player	2026-02-09 20:58:19.125182
10	Raven621	handler@rubicon.com	coralrelease	Japan	player	2026-02-09 20:58:19.125182
11	HarvestMoonVet	farmer@valley.com	bluechicken	Indonesia	player	2026-02-09 20:58:19.125182
12	RuskiBoi	cyka@blyat.com	rushb	Russia	player	2026-02-09 20:58:19.125182
13	YesKing	ImALionPizzaChicken@gamer.com	pass123	USA	player	2026-04-20 09:43:42.837448
14	GamerRemote	remote@digadi.com	pass123	Indonesia	player	2026-05-18 12:11:33
\.

COPY public.developer_members (user_id, dev_id, joined_at) FROM stdin;
2	1	2026-02-09
7	3	1996-08-24
8	5	2015-09-15
\.

COPY public.games (game_id, title, description, release_date, status, price) FROM stdin;
1	Armored Core VI: Fires of Rubicon	High-octane mecha action game.	2023-08-25	released	599000.00
2	Stardew Valley	Open-ended country-life RPG.	2016-02-26	released	115999.00
3	Red Dead Redemption 2	Epic tale of life in America.	2018-10-26	released	640000.00
4	Half-Life 2	Sci-fi FPS that redefined the genre with physics puzzles.	2004-11-16	released	90999.00
5	Deltarune	Parallel universe RPG from the creator of Undertale.	2018-10-31	early_access	0.00
6	Counter-Strike 2	Tactical shooter replacing CS:GO with Source 2 engine.	2023-09-27	released	0.00
7	Omori	Omori is a psychological horror RPG about a hikikomori teenager named Sunny who explores a surreal dream world as his alter ego, Omori, to repress a traumatic past event.	2020-12-25	released	108.99
\.

COPY public.games_v1 (game_id, title, price, status) FROM stdin;
2	Stardew Valley	115999.00	released
3	Red Dead Redemption 2	640000.00	released
4	Half-Life 2	90999.00	released
6	Counter-Strike 2	0.00	released
7	Omori	108.99	released
1	Armored Core VI: Fires of Rubicon	150000.00	released
5	Deltarune	100000.00	early_access
\.

COPY public.game_developers (game_id, dev_id) FROM stdin;
1	4
2	1
3	2
4	3
5	5
6	3
\.

COPY public.game_tags (game_id, tag_name) FROM stdin;
1	Mecha
1	Action
2	Simulation
3	Open World
2	Indie
2	Farming
3	Story Rich
4	FPS
4	Sci-Fi
5	RPG
5	Pixel Art
6	FPS
6	Multiplayer
6	Competitive
\.

SELECT pg_catalog.setval('public.developers_dev_id_seq', 7, true);
SELECT pg_catalog.setval('public.games_game_id_seq', 7, true);
SELECT pg_catalog.setval('public.users_user_id_seq', 15, true);