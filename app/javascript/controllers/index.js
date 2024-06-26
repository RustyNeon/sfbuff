// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import BattleModalController from "./battle_modal_controller"
application.register("battle-modal", BattleModalController)

import BattlePointsChartController from "./battle_points_chart_controller"
application.register("battle-points-chart", BattlePointsChartController)

import FormAutoSubmitController from "./form_auto_submit_controller"
application.register("form-auto-submit", FormAutoSubmitController)

import IntervalReloaderController from "./interval_reloader_controller"
application.register("interval-reloader", IntervalReloaderController)
