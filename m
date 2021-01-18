Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9EA2FAC9F
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Jan 2021 22:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394655AbhARV1B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Jan 2021 16:27:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbhARKLL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Jan 2021 05:11:11 -0500
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqeRulDhHNHgL6fy8LbaFwThp5hQYIRRAVQEh8ugmNg=;
        b=ntnlxHd7IuHcgbEk0ZOKpUm9vd+xZnLDVgXvuho+1zC+/NPMGSii0wc39ObkOAtY1tTzYa
        WdrxQJhdkuFV4PPSmaQamIUEijaufnr7B6BChBmey10HJFTwLdOuGAcpx2apENRiZ7oXzP
        Hbo0pn/oWJPQLJ+NLnBHs+jCs4kt8wNdkv/UuCtqpwNjUvtbHUnPpI4pGSEFuAcct+O7fh
        lNMWV7cfMm9+pOFFa2TOi4CDYAh8HsW6HQ5eK1a7zwR3P81A4sUAKEA4612w7mGx212Ves
        NfDKwMsamb3/dYcJXOo0CgpDWDWq3y/i/c1kM4WsgzfKGl4syY9Uv+Cm3cfYNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqeRulDhHNHgL6fy8LbaFwThp5hQYIRRAVQEh8ugmNg=;
        b=kcwnSThXdgqdPmMpuJcSMgWMmx4FqCXJRH2KousTyv2QEW5oeWom7TKKDF3VCZLtWDYh1/
        XHJJFC56Jt32FRBQ==
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v3 05/19] scsi: isci: port: link down: Pass gfp_t flags
Date:   Mon, 18 Jan 2021 11:09:41 +0100
Message-Id: <20210118100955.1761652-6-a.darwish@linutronix.de>
In-Reply-To: <20210118100955.1761652-1-a.darwish@linutronix.de>
References: <20210118100955.1761652-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the new libsas event notifiers API, which requires callers to
explicitly pass the gfp_t memory allocation flags.

sas_notify_phy_event() is exclusively called by isci_port_link_down().
Below is the context analysis for all of its call chains:

port.c: port_timeout(), atomic, timer callback                  (*)
spin_lock_irqsave(isci_host::scic_lock, )
  -> port_state_machine_change(..., SCI_PORT_FAILED)
    -> enter SCI port state: *SCI_PORT_FAILED*
      -> sci_port_failed_state_enter()
        -> isci_port_hard_reset_complete()
          -> isci_port_link_down()

port.c: isci_port_perform_hard_reset()
spin_lock_irqsave(isci_host::scic_lock, )
  -> port.c: sci_port_hard_reset(), atomic                      (*)
    -> phy.c: sci_phy_reset()
      -> sci_change_state(SCI_PHY_RESETTING)
        -> enter SCI PHY state: *SCI_PHY_RESETTING*
          -> sci_phy_resetting_state_enter()
            -> port.c: sci_port_deactivate_phy()
	      -> isci_port_link_down()

port.c: enter SCI port state: *SCI_PORT_READY*                  # Cont. from [1]
  -> sci_port_ready_state_enter()
    -> isci_port_hard_reset_complete()
      -> isci_port_link_down()

phy.c: enter SCI state: *SCI_PHY_STOPPED*                       # Cont. from [2]
  -> sci_phy_stopped_state_enter()
    -> host.c: sci_controller_link_down()
      -> ->link_down_handler()
      == port_config.c: sci_apc_agent_link_down()
        -> port.c: sci_port_remove_phy()
          -> sci_port_deactivate_phy()
            -> isci_port_link_down()
      == port_config.c: sci_mpc_agent_link_down()
        -> port.c: sci_port_link_down()
          -> sci_port_deactivate_phy()
            -> isci_port_link_down()

phy.c: enter SCI state: *SCI_PHY_STARTING*                      # Cont. from [3]
  -> sci_phy_starting_state_enter()
    -> host.c: sci_controller_link_down()
      -> ->link_down_handler()
      == port_config.c: sci_apc_agent_link_down()
        -> port.c: sci_port_remove_phy()
          -> isci_port_link_down()
      == port_config.c: sci_mpc_agent_link_down()
        -> port.c: sci_port_link_down()
          -> sci_port_deactivate_phy()
            -> isci_port_link_down()

[1] Call chains for 'enter SCI port state: *SCI_PORT_READY*'
------------------------------------------------------------

host.c: isci_host_init()                                        (@)
spin_lock_irq(isci_host::scic_lock)
  -> sci_controller_initialize(), atomic                        (*)
    -> port_config.c: sci_port_configuration_agent_initialize()
      -> sci_mpc_agent_validate_phy_configuration()
        -> port.c: sci_port_add_phy()
          -> sci_port_general_link_up_handler()
            -> port_state_machine_change(, SCI_PORT_READY)
              -> enter port state *SCI_PORT_READY*

host.c: isci_host_start()                                       (@)
spin_lock_irq(isci_host::scic_lock)
  -> host.c: sci_controller_start(), atomic                     (*)
    -> host.c: sci_port_start()
      -> port.c: port_state_machine_change(, SCI_PORT_READY)
        -> enter port state *SCI_PORT_READY*

port_config.c: apc_agent_timeout(), atomic, timer callback      (*)
  -> sci_apc_agent_configure_ports()
    -> port.c: sci_port_add_phy()
      -> sci_port_general_link_up_handler()
        -> port_state_machine_change(, SCI_PORT_READY)
          -> enter port state *SCI_PORT_READY*

port_config.c: mpc_agent_timeout(), atomic, timer callback      (*)
spin_lock_irqsave(isci_host::scic_lock, )
  -> ->link_up_handler()
  == port.c: sci_apc_agent_link_up()
    -> sci_port_general_link_up_handler()
      -> port_state_machine_change(, SCI_PORT_READY)
        -> enter port state *SCI_PORT_READY*
  == port.c: sci_mpc_agent_link_up()
    -> port.c: sci_port_link_up()
      -> sci_port_general_link_up_handler()
        -> port_state_machine_change(, SCI_PORT_READY)
          -> enter port state *SCI_PORT_READY*

phy.c: enter SCI state: SCI_PHY_SUB_FINAL                       # Cont. from [1A]
  -> sci_phy_starting_final_substate_enter()
    -> sci_change_state(SCI_PHY_READY)
      -> enter SCI state: *SCI_PHY_READY*
        -> sci_phy_ready_state_enter()
          -> host.c: sci_controller_link_up()
            -> port_agent.link_up_handler()
            == port_config.c: sci_apc_agent_link_up()
              -> port.c: sci_port_link_up()
                -> sci_port_general_link_up_handler()
                  -> port_state_machine_change(, SCI_PORT_READY)
                    -> enter port state *SCI_PORT_READY*
            == port_config.c: sci_mpc_agent_link_up()
              -> port.c: sci_port_link_up()
                -> sci_port_general_link_up_handler()
                  -> port_state_machine_change(, SCI_PORT_READY)
                    -> enter port state *SCI_PORT_READY*

[1A] Call chains for entering SCI state: *SCI_PHY_SUB_FINAL*
------------------------------------------------------------

host.c: power_control_timeout(), atomic, timer callback         (*)
spin_lock_irqsave(isci_host::scic_lock, )
  -> phy.c: sci_phy_consume_power_handler()
    -> phy.c: sci_change_state(SCI_PHY_SUB_FINAL)

host.c: sci_controller_error_handler(): atomic, irq handler     (*)
OR host.c: sci_controller_completion_handler(), atomic, tasklet (*)
  -> sci_controller_process_completions()
    -> sci_controller_unsolicited_frame()
      -> phy.c: sci_phy_frame_handler()
        -> sci_change_state(SCI_PHY_SUB_AWAIT_SAS_POWER)
          -> sci_phy_starting_await_sas_power_substate_enter()
            -> host.c: sci_controller_power_control_queue_insert()
              -> phy.c: sci_phy_consume_power_handler()
                -> sci_change_state(SCI_PHY_SUB_FINAL)
        -> sci_change_state(SCI_PHY_SUB_FINAL)
    -> sci_controller_event_completion()
      -> phy.c: sci_phy_event_handler()
        -> sci_phy_start_sata_link_training()
          -> sci_change_state(SCI_PHY_SUB_AWAIT_SATA_POWER)
            -> sci_phy_starting_await_sata_power_substate_enter
              -> host.c: sci_controller_power_control_queue_insert()
                -> phy.c: sci_phy_consume_power_handler()
                  -> sci_change_state(SCI_PHY_SUB_FINAL)

[2] Call chains for entering state: *SCI_PHY_STOPPED*
-----------------------------------------------------

host.c: isci_host_init()                                        (@)
spin_lock_irq(isci_host::scic_lock)
  -> sci_controller_initialize(), atomic                        (*)
      -> phy.c: sci_phy_initialize()
        -> phy.c: sci_phy_link_layer_initialization()
          -> phy.c: sci_change_state(SCI_PHY_STOPPED)

init.c: PCI ->remove() || PM_OPS ->suspend,  process context    (+)
  -> host.c: isci_host_deinit()
    -> sci_controller_stop_phys()
      -> phy.c: sci_phy_stop()
	-> sci_change_state(SCI_PHY_STOPPED)

phy.c: isci_phy_control()
spin_lock_irqsave(isci_host::scic_lock, )
  -> sci_phy_stop(), atomic                                     (*)
    -> sci_change_state(SCI_PHY_STOPPED)

[3] Call chains for entering state: *SCI_PHY_STARTING*
------------------------------------------------------

phy.c: phy_sata_timeout(), atimer, timer callback               (*)
spin_lock_irqsave(isci_host::scic_lock, )
  -> sci_change_state(SCI_PHY_STARTING)

host.c: phy_startup_timeout(), atomic, timer callback           (*)
spin_lock_irqsave(isci_host::scic_lock, )
  -> sci_controller_start_next_phy()
    -> sci_phy_start()
      -> sci_change_state(SCI_PHY_STARTING)

host.c: isci_host_start()                                       (@)
spin_lock_irq(isci_host::scic_lock)
  -> sci_controller_start(), atomic                             (*)
    -> sci_controller_start_next_phy()
      -> sci_phy_start()
        -> sci_change_state(SCI_PHY_STARTING)

phy.c: Enter SCI state *SCI_PHY_SUB_FINAL*, atomic, check above (*)
  -> sci_change_state(SCI_PHY_SUB_FINAL)
    -> sci_phy_starting_final_substate_enter()
      -> sci_change_state(SCI_PHY_READY)
        -> Enter SCI state: *SCI_PHY_READY*
          -> sci_phy_ready_state_enter()
            -> host.c: sci_controller_link_up()
              -> sci_controller_start_next_phy()
                -> sci_phy_start()
                  -> sci_change_state(SCI_PHY_STARTING)

phy.c: sci_phy_event_handler(), atomic, discussed earlier       (*)
  -> sci_change_state(SCI_PHY_STARTING), 11 instances

phy.c: enter SCI state: *SCI_PHY_RESETTING*, atomic, discussed  (*)
  -> sci_phy_resetting_state_enter()
    -> sci_change_state(SCI_PHY_STARTING)

As can be seen from the "(*)" markers above, almost all the call-chains
are atomic. The only exception, marked with "(+)", is a PCI ->remove()
and PM_OPS ->suspend() cold path. Thus, pass GFP_ATOMIC to the libsas
phy event notifier.

Note, The now-replaced libsas APIs used in_interrupt() to implicitly
decide which memory allocation type to use.  This was only partially
correct, as it fails to choose the correct GFP flags when just
preemption or interrupts are disabled. Such buggy code paths are marked
with "(@)" in the call chains above.

Fixes: 1c393b970e0f ("scsi: libsas: Use dynamic alloced work to avoid sas event lost")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: John Garry <john.garry@huawei.com>
Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
---
 drivers/scsi/isci/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/port.c b/drivers/scsi/isci/port.c
index 8d9349738067..a3c58718c260 100644
--- a/drivers/scsi/isci/port.c
+++ b/drivers/scsi/isci/port.c
@@ -269,8 +269,8 @@ static void isci_port_link_down(struct isci_host *isci_host,
 	 * isci_port_deformed and isci_dev_gone functions.
 	 */
 	sas_phy_disconnected(&isci_phy->sas_phy);
-	sas_notify_phy_event(&isci_phy->sas_phy,
-					   PHYE_LOSS_OF_SIGNAL);
+	sas_notify_phy_event_gfp(&isci_phy->sas_phy,
+				 PHYE_LOSS_OF_SIGNAL, GFP_ATOMIC);
 
 	dev_dbg(&isci_host->pdev->dev,
 		"%s: isci_port = %p - Done\n", __func__, isci_port);
-- 
2.30.0

