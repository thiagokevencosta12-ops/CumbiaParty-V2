--!strict
export type Note = {id:string,time:number,lane:number,duration:number?}
export type Chart = {id:string,bpm:number,duration:number,notes:{Note},accelerated:boolean?}
export type Stats = {score:number,combo:number,maxCombo:number,Perfect:number,Great:number,Good:number,Miss:number,
 PerfectHold:number,GoodHold:number,BrokenHold:number}
export type NoteRequest = {protocolVersion:number,sessionId:string,noteId:string,lane:number,inputTime:number,
 action:("Begin" | "End" | "HoldPulse")?}
-- Existing RemoteEvents, protocol 3:
-- ClientReady C->S: snapshot request.
-- RhythmControl C->S: Start (solo), Cancel + sessionId/battleId,
-- Invite + targetUserId, Accept/Decline + inviteId, CancelInvite.
-- SubmitNote C->S: raw input only. Omitted action means Begin (solo compatibility).
-- NoteResult S->C: Holding acknowledgement OR final authoritative judgment/stats.
-- BattleState S->C: Solo/Combat/Invite mode; Playing/Waiting/Finished/etc.
-- Combat snapshots contain battleId, wave, activeUserId, players[{userId,name,hp}],
-- deadline, winnerUserId, draw, reason. Only active player receives the chart.
-- Hold state: Begin -> periodic HoldPulse -> End; stale/missing release breaks hold.
-- Client never submits HP, damage, grade, combo, winner or reward.
-- TournamentRequest C->S: Join, LeaveQueue, ExitView, Withdraw, Snapshot.
-- TournamentState S->C: queue (human count only), optional tournament bracket.
-- Participant id is opaque; genuine UserId only belongs to human Players.
-- Presentation never contains controller kind, simulated accuracy or PRNG seed.
export type CompetitorPresentation = {id:number|string,name:string,appearance:{color:number,style:number}}
export type TournamentRequest = {action:"Join"|"LeaveQueue"|"ExitView"|"Withdraw"|"Snapshot"}

-- LobbyRequest: Return. LobbyState: OpenTournament or Returned. No queue enrollment on proximity.
-- LobbyState S->C also carries ArenaAssigned {matchId,arenaId,tournamentId,battleId?,camera:CFrame,deadline,presentation?}
-- presentation = {startAt,endsAt,round,arenaId,players:{CompetitorPresentation},shots:{[string]:CFrame}}.
-- The clock is server-owned; snapshots resume the current stage, never restart the intro.
-- No battle exists during the presentation lease; headless matches bypass it.
-- and ArenaReleased {matchId}. These are presentation leases, never client arena claims.
return table.freeze({})

