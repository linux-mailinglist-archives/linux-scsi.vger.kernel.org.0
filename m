Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314FB732B4B
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Jun 2023 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbjFPJXW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Jun 2023 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjFPJXU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Jun 2023 05:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B910F6;
        Fri, 16 Jun 2023 02:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AC0614DB;
        Fri, 16 Jun 2023 09:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D080FC433C0;
        Fri, 16 Jun 2023 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907394;
        bh=r5IcoVA2yheEONUy2dvvUml3A45lXhy96kZaBQkshDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdBuk5LaZHn1ouCgnIf0ASGmf9wF3cSj02tvmhjl0IuA1ToT5qCRHcSPfu0lIvDF6
         Hh7iS3sbaY+i/egTw8zRkbwF5MBEOMufiCry+Bd1BallMIUShs4ck0OWaD4ZYDRQ2X
         +uhO3P6C+G2EpDf+yn1fTAKZ8yd5LxuvNHgFZy5yYpo1KCocpMGViZ7jPVvRPZc9IK
         ZHDhH1sWJtKNBYSB5BjMtstFrl1ColeLROWFVglnhIxSCrhJt+PVEZh8x2g4LXv3Y+
         FfDv2MZOqLk1IHblFZCYnoxatLsMf7YuHHdqOjAYqlt/K3eOZXrCfmnzBpweJ+t2A+
         eeIj7lYQn4yZw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: bfa: fix function pointer type mismatch for state machines
Date:   Fri, 16 Jun 2023 11:22:10 +0200
Message-Id: <20230616092233.3229414-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616092233.3229414-1-arnd@kernel.org>
References: <20230616092233.3229414-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The bfa driver is full of state machines and a generic abstraction layer
for them. This relies on casting function pointers, but that is no longer
allowed when CONFIG_CFI_CLANG is enabled and causes a huge number of
warnings like:

drivers/scsi/bfa/bfad.c:169:3: error: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
                bfa_sm_set_state(bfad, bfad_sm_created);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rework the mechanism to no longer require the function pointer casts,
by having separate types for each individual state machine. This in
turn requires moving the enum definitions for each state machine
into the header files in order to define the typedef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/bfa/bfa.h           |  21 ++-
 drivers/scsi/bfa/bfa_cs.h        |  21 +--
 drivers/scsi/bfa/bfa_fcpim.c     |  51 -----
 drivers/scsi/bfa/bfa_fcpim.h     |  66 ++++++-
 drivers/scsi/bfa/bfa_fcs.h       | 310 +++++++++++++++++++++----------
 drivers/scsi/bfa/bfa_fcs_fcpim.c |  23 ++-
 drivers/scsi/bfa/bfa_fcs_lport.c | 112 ++---------
 drivers/scsi/bfa/bfa_fcs_rport.c |  34 ++--
 drivers/scsi/bfa/bfa_ioc.c       |  85 ++++-----
 drivers/scsi/bfa/bfa_ioc.h       |  76 ++++++--
 drivers/scsi/bfa/bfa_svc.c       |  72 +++----
 drivers/scsi/bfa/bfa_svc.h       | 115 +++++++++---
 drivers/scsi/bfa/bfad.c          |  14 +-
 drivers/scsi/bfa/bfad_drv.h      |  31 ++--
 14 files changed, 589 insertions(+), 442 deletions(-)

diff --git a/drivers/scsi/bfa/bfa.h b/drivers/scsi/bfa/bfa.h
index f30fe324e6ecc..4cb9249e583cc 100644
--- a/drivers/scsi/bfa/bfa.h
+++ b/drivers/scsi/bfa/bfa.h
@@ -215,8 +215,27 @@ struct bfa_faa_args_s {
 	bfa_boolean_t		busy;
 };
 
+/*
+ * IOCFC state machine definitions/declarations
+ */
+enum iocfc_event {
+	IOCFC_E_INIT		= 1,	/* IOCFC init request		*/
+	IOCFC_E_START		= 2,	/* IOCFC mod start request	*/
+	IOCFC_E_STOP		= 3,	/* IOCFC stop request		*/
+	IOCFC_E_ENABLE		= 4,	/* IOCFC enable request		*/
+	IOCFC_E_DISABLE		= 5,	/* IOCFC disable request	*/
+	IOCFC_E_IOC_ENABLED	= 6,	/* IOC enabled message		*/
+	IOCFC_E_IOC_DISABLED	= 7,	/* IOC disabled message		*/
+	IOCFC_E_IOC_FAILED	= 8,	/* failure notice by IOC sm	*/
+	IOCFC_E_DCONF_DONE	= 9,	/* dconf read/write done	*/
+	IOCFC_E_CFG_DONE	= 10,	/* IOCFC config complete	*/
+};
+
+struct bfa_iocfc_s;
+typedef void (*bfa_iocfs_fsm_t)(struct bfa_iocfc_s *, enum iocfc_event);
+
 struct bfa_iocfc_s {
-	bfa_fsm_t		fsm;
+	bfa_iocfs_fsm_t		fsm;
 	struct bfa_s		*bfa;
 	struct bfa_iocfc_cfg_s	cfg;
 	u32		req_cq_pi[BFI_IOC_MAX_CQS];
diff --git a/drivers/scsi/bfa/bfa_cs.h b/drivers/scsi/bfa/bfa_cs.h
index 6b606bf589b42..6650b1dbb1ed0 100644
--- a/drivers/scsi/bfa/bfa_cs.h
+++ b/drivers/scsi/bfa/bfa_cs.h
@@ -187,10 +187,10 @@ typedef void (*bfa_sm_t)(void *sm, int event);
 #define bfa_sm_state_decl(oc, st, otype, etype)		\
 	static void oc ## _sm_ ## st(otype * fsm, etype event)
 
-#define bfa_sm_set_state(_sm, _state)	((_sm)->sm = (bfa_sm_t)(_state))
+#define bfa_sm_set_state(_sm, _state)	((_sm)->sm = (_state))
 #define bfa_sm_send_event(_sm, _event)	((_sm)->sm((_sm), (_event)))
 #define bfa_sm_get_state(_sm)		((_sm)->sm)
-#define bfa_sm_cmp_state(_sm, _state)	((_sm)->sm == (bfa_sm_t)(_state))
+#define bfa_sm_cmp_state(_sm, _state)	((_sm)->sm == (_state))
 
 /*
  * For converting from state machine function to state encoding.
@@ -200,7 +200,7 @@ struct bfa_sm_table_s {
 	int		state;	/*  state machine encoding	*/
 	char		*name;	/*  state name for display	*/
 };
-#define BFA_SM(_sm)	((bfa_sm_t)(_sm))
+#define BFA_SM(_sm)	(_sm)
 
 /*
  * State machine with entry actions.
@@ -218,24 +218,13 @@ typedef void (*bfa_fsm_t)(void *fsm, int event);
 	static void oc ## _sm_ ## st ## _entry(otype * fsm)
 
 #define bfa_fsm_set_state(_fsm, _state) do {	\
-	(_fsm)->fsm = (bfa_fsm_t)(_state);      \
+	(_fsm)->fsm = (_state);      \
 	_state ## _entry(_fsm);      \
 } while (0)
 
 #define bfa_fsm_send_event(_fsm, _event)	((_fsm)->fsm((_fsm), (_event)))
 #define bfa_fsm_get_state(_fsm)			((_fsm)->fsm)
-#define bfa_fsm_cmp_state(_fsm, _state)		\
-	((_fsm)->fsm == (bfa_fsm_t)(_state))
-
-static inline int
-bfa_sm_to_state(struct bfa_sm_table_s *smt, bfa_sm_t sm)
-{
-	int	i = 0;
-
-	while (smt[i].sm && smt[i].sm != sm)
-		i++;
-	return smt[i].state;
-}
+#define bfa_fsm_cmp_state(_fsm, _state)		((_fsm)->fsm == (_state))
 
 /*
  * @ Generic wait counter.
diff --git a/drivers/scsi/bfa/bfa_fcpim.c b/drivers/scsi/bfa/bfa_fcpim.c
index 7ad22288071b1..28ae4dc14dc9c 100644
--- a/drivers/scsi/bfa/bfa_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcpim.c
@@ -64,21 +64,6 @@ enum bfa_ioim_lm_ua_status {
 	BFA_IOIM_LM_UA_SET = 1,
 };
 
-/*
- *  itnim state machine event
- */
-enum bfa_itnim_event {
-	BFA_ITNIM_SM_CREATE = 1,	/*  itnim is created */
-	BFA_ITNIM_SM_ONLINE = 2,	/*  itnim is online */
-	BFA_ITNIM_SM_OFFLINE = 3,	/*  itnim is offline */
-	BFA_ITNIM_SM_FWRSP = 4,		/*  firmware response */
-	BFA_ITNIM_SM_DELETE = 5,	/*  deleting an existing itnim */
-	BFA_ITNIM_SM_CLEANUP = 6,	/*  IO cleanup completion */
-	BFA_ITNIM_SM_SLER = 7,		/*  second level error recovery */
-	BFA_ITNIM_SM_HWFAIL = 8,	/*  IOC h/w failure event */
-	BFA_ITNIM_SM_QRESUME = 9,	/*  queue space available */
-};
-
 /*
  *  BFA IOIM related definitions
  */
@@ -98,30 +83,6 @@ enum bfa_itnim_event {
 		(__fcpim)->profile_start(__ioim);			\
 } while (0)
 
-/*
- * IO state machine events
- */
-enum bfa_ioim_event {
-	BFA_IOIM_SM_START	= 1,	/*  io start request from host */
-	BFA_IOIM_SM_COMP_GOOD	= 2,	/*  io good comp, resource free */
-	BFA_IOIM_SM_COMP	= 3,	/*  io comp, resource is free */
-	BFA_IOIM_SM_COMP_UTAG	= 4,	/*  io comp, resource is free */
-	BFA_IOIM_SM_DONE	= 5,	/*  io comp, resource not free */
-	BFA_IOIM_SM_FREE	= 6,	/*  io resource is freed */
-	BFA_IOIM_SM_ABORT	= 7,	/*  abort request from scsi stack */
-	BFA_IOIM_SM_ABORT_COMP	= 8,	/*  abort from f/w */
-	BFA_IOIM_SM_ABORT_DONE	= 9,	/*  abort completion from f/w */
-	BFA_IOIM_SM_QRESUME	= 10,	/*  CQ space available to queue IO */
-	BFA_IOIM_SM_SGALLOCED	= 11,	/*  SG page allocation successful */
-	BFA_IOIM_SM_SQRETRY	= 12,	/*  sequence recovery retry */
-	BFA_IOIM_SM_HCB		= 13,	/*  bfa callback complete */
-	BFA_IOIM_SM_CLEANUP	= 14,	/*  IO cleanup from itnim */
-	BFA_IOIM_SM_TMSTART	= 15,	/*  IO cleanup from tskim */
-	BFA_IOIM_SM_TMDONE	= 16,	/*  IO cleanup from tskim */
-	BFA_IOIM_SM_HWFAIL	= 17,	/*  IOC h/w failure event */
-	BFA_IOIM_SM_IOTOV	= 18,	/*  ITN offline TOV */
-};
-
 
 /*
  *  BFA TSKIM related definitions
@@ -141,18 +102,6 @@ enum bfa_ioim_event {
 } while (0)
 
 
-enum bfa_tskim_event {
-	BFA_TSKIM_SM_START	= 1,	/*  TM command start		*/
-	BFA_TSKIM_SM_DONE	= 2,	/*  TM completion		*/
-	BFA_TSKIM_SM_QRESUME	= 3,	/*  resume after qfull		*/
-	BFA_TSKIM_SM_HWFAIL	= 5,	/*  IOC h/w failure event	*/
-	BFA_TSKIM_SM_HCB	= 6,	/*  BFA callback completion	*/
-	BFA_TSKIM_SM_IOS_DONE	= 7,	/*  IO and sub TM completions	*/
-	BFA_TSKIM_SM_CLEANUP	= 8,	/*  TM cleanup on ITN offline	*/
-	BFA_TSKIM_SM_CLEANUP_DONE = 9,	/*  TM abort completion	*/
-	BFA_TSKIM_SM_UTAG	= 10,	/*  TM completion unknown tag  */
-};
-
 /*
  * forward declaration for BFA ITNIM functions
  */
diff --git a/drivers/scsi/bfa/bfa_fcpim.h b/drivers/scsi/bfa/bfa_fcpim.h
index 8bf09433549b9..4499f84c2d812 100644
--- a/drivers/scsi/bfa/bfa_fcpim.h
+++ b/drivers/scsi/bfa/bfa_fcpim.h
@@ -154,12 +154,39 @@ struct bfa_fcp_mod_s {
 	int			throttle_update_required;
 };
 
+/*
+ * IO state machine events
+ */
+enum bfa_ioim_event {
+	BFA_IOIM_SM_START	= 1,	/*  io start request from host */
+	BFA_IOIM_SM_COMP_GOOD	= 2,	/*  io good comp, resource free */
+	BFA_IOIM_SM_COMP	= 3,	/*  io comp, resource is free */
+	BFA_IOIM_SM_COMP_UTAG	= 4,	/*  io comp, resource is free */
+	BFA_IOIM_SM_DONE	= 5,	/*  io comp, resource not free */
+	BFA_IOIM_SM_FREE	= 6,	/*  io resource is freed */
+	BFA_IOIM_SM_ABORT	= 7,	/*  abort request from scsi stack */
+	BFA_IOIM_SM_ABORT_COMP	= 8,	/*  abort from f/w */
+	BFA_IOIM_SM_ABORT_DONE	= 9,	/*  abort completion from f/w */
+	BFA_IOIM_SM_QRESUME	= 10,	/*  CQ space available to queue IO */
+	BFA_IOIM_SM_SGALLOCED	= 11,	/*  SG page allocation successful */
+	BFA_IOIM_SM_SQRETRY	= 12,	/*  sequence recovery retry */
+	BFA_IOIM_SM_HCB		= 13,	/*  bfa callback complete */
+	BFA_IOIM_SM_CLEANUP	= 14,	/*  IO cleanup from itnim */
+	BFA_IOIM_SM_TMSTART	= 15,	/*  IO cleanup from tskim */
+	BFA_IOIM_SM_TMDONE	= 16,	/*  IO cleanup from tskim */
+	BFA_IOIM_SM_HWFAIL	= 17,	/*  IOC h/w failure event */
+	BFA_IOIM_SM_IOTOV	= 18,	/*  ITN offline TOV */
+};
+
+struct bfa_ioim_s;
+typedef void (*bfa_ioim_sm_t)(struct bfa_ioim_s *, enum bfa_ioim_event);
+
 /*
  * BFA IO (initiator mode)
  */
 struct bfa_ioim_s {
 	struct list_head	qe;		/*  queue elememt	*/
-	bfa_sm_t		sm;		/*  BFA ioim state machine */
+	bfa_ioim_sm_t		sm;		/*  BFA ioim state machine */
 	struct bfa_s		*bfa;		/*  BFA module	*/
 	struct bfa_fcpim_s	*fcpim;		/*  parent fcpim module */
 	struct bfa_itnim_s	*itnim;		/*  i-t-n nexus for this IO  */
@@ -186,12 +213,27 @@ struct bfa_ioim_sp_s {
 	struct bfa_tskim_s	*tskim;		/*  Relevant TM cmd	*/
 };
 
+enum bfa_tskim_event {
+	BFA_TSKIM_SM_START	= 1,	/*  TM command start		*/
+	BFA_TSKIM_SM_DONE	= 2,	/*  TM completion		*/
+	BFA_TSKIM_SM_QRESUME	= 3,	/*  resume after qfull		*/
+	BFA_TSKIM_SM_HWFAIL	= 5,	/*  IOC h/w failure event	*/
+	BFA_TSKIM_SM_HCB	= 6,	/*  BFA callback completion	*/
+	BFA_TSKIM_SM_IOS_DONE	= 7,	/*  IO and sub TM completions	*/
+	BFA_TSKIM_SM_CLEANUP	= 8,	/*  TM cleanup on ITN offline	*/
+	BFA_TSKIM_SM_CLEANUP_DONE = 9,	/*  TM abort completion	*/
+	BFA_TSKIM_SM_UTAG	= 10,	/*  TM completion unknown tag  */
+};
+
+struct bfa_tskim_s;
+typedef void (*bfa_tskim_sm_t)(struct bfa_tskim_s *, enum bfa_tskim_event);
+
 /*
  * BFA Task management command (initiator mode)
  */
 struct bfa_tskim_s {
 	struct list_head	qe;
-	bfa_sm_t		sm;
+	bfa_tskim_sm_t		sm;
 	struct bfa_s		*bfa;	/*  BFA module  */
 	struct bfa_fcpim_s	*fcpim;	/*  parent fcpim module	*/
 	struct bfa_itnim_s	*itnim;	/*  i-t-n nexus for this IO  */
@@ -208,12 +250,30 @@ struct bfa_tskim_s {
 	enum bfi_tskim_status   tsk_status;  /*  TM status	*/
 };
 
+/*
+ *  itnim state machine event
+ */
+enum bfa_itnim_event {
+	BFA_ITNIM_SM_CREATE = 1,	/*  itnim is created */
+	BFA_ITNIM_SM_ONLINE = 2,	/*  itnim is online */
+	BFA_ITNIM_SM_OFFLINE = 3,	/*  itnim is offline */
+	BFA_ITNIM_SM_FWRSP = 4,		/*  firmware response */
+	BFA_ITNIM_SM_DELETE = 5,	/*  deleting an existing itnim */
+	BFA_ITNIM_SM_CLEANUP = 6,	/*  IO cleanup completion */
+	BFA_ITNIM_SM_SLER = 7,		/*  second level error recovery */
+	BFA_ITNIM_SM_HWFAIL = 8,	/*  IOC h/w failure event */
+	BFA_ITNIM_SM_QRESUME = 9,	/*  queue space available */
+};
+
+struct bfa_itnim_s;
+typedef void (*bfa_itnim_sm_t)(struct bfa_itnim_s *, enum bfa_itnim_event);
+
 /*
  * BFA i-t-n (initiator mode)
  */
 struct bfa_itnim_s {
 	struct list_head	qe;	/*  queue element	*/
-	bfa_sm_t		sm;	/*  i-t-n im BFA state machine  */
+	bfa_itnim_sm_t		sm;	/*  i-t-n im BFA state machine  */
 	struct bfa_s		*bfa;	/*  bfa instance	*/
 	struct bfa_rport_s	*rport;	/*  bfa rport	*/
 	void			*ditn;	/*  driver i-t-n structure	*/
diff --git a/drivers/scsi/bfa/bfa_fcs.h b/drivers/scsi/bfa/bfa_fcs.h
index c1baf5cd0d3e8..a1ad94a11a28e 100644
--- a/drivers/scsi/bfa/bfa_fcs.h
+++ b/drivers/scsi/bfa/bfa_fcs.h
@@ -19,22 +19,6 @@
 
 #define BFA_FCS_OS_STR_LEN		64
 
-/*
- *  lps_pvt BFA LPS private functions
- */
-
-enum bfa_lps_event {
-	BFA_LPS_SM_LOGIN	= 1,	/* login request from user      */
-	BFA_LPS_SM_LOGOUT	= 2,	/* logout request from user     */
-	BFA_LPS_SM_FWRSP	= 3,	/* f/w response to login/logout */
-	BFA_LPS_SM_RESUME	= 4,	/* space present in reqq queue  */
-	BFA_LPS_SM_DELETE	= 5,	/* lps delete from user         */
-	BFA_LPS_SM_OFFLINE	= 6,	/* Link is offline              */
-	BFA_LPS_SM_RX_CVL	= 7,	/* Rx clear virtual link        */
-	BFA_LPS_SM_SET_N2N_PID  = 8,	/* Set assigned PID for n2n */
-};
-
-
 /*
  * !!! Only append to the enums defined here to avoid any versioning
  * !!! needed between trace utility and driver version
@@ -59,8 +43,30 @@ struct bfa_fcs_s;
 #define BFA_FCS_PID_IS_WKA(pid)  ((bfa_ntoh3b(pid) > 0xFFF000) ?  1 : 0)
 #define BFA_FCS_MAX_RPORT_LOGINS 1024
 
+/*
+ * VPort NS State Machine events
+ */
+enum vport_ns_event {
+	NSSM_EVENT_PORT_ONLINE = 1,
+	NSSM_EVENT_PORT_OFFLINE = 2,
+	NSSM_EVENT_PLOGI_SENT = 3,
+	NSSM_EVENT_RSP_OK = 4,
+	NSSM_EVENT_RSP_ERROR = 5,
+	NSSM_EVENT_TIMEOUT = 6,
+	NSSM_EVENT_NS_QUERY = 7,
+	NSSM_EVENT_RSPNID_SENT = 8,
+	NSSM_EVENT_RFTID_SENT = 9,
+	NSSM_EVENT_RFFID_SENT = 10,
+	NSSM_EVENT_GIDFT_SENT = 11,
+	NSSM_EVENT_RNNID_SENT = 12,
+	NSSM_EVENT_RSNN_NN_SENT = 13,
+};
+
+struct bfa_fcs_lport_ns_s;
+typedef void (*bfa_fcs_lport_ns_sm_t)(struct bfa_fcs_lport_ns_s *fsm, enum vport_ns_event);
+
 struct bfa_fcs_lport_ns_s {
-	bfa_sm_t        sm;		/*  state machine */
+	bfa_fcs_lport_ns_sm_t sm;	/*  state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_s *port;	/*  parent port */
 	struct bfa_fcxp_s *fcxp;
@@ -69,9 +75,23 @@ struct bfa_fcs_lport_ns_s {
 	u8	num_rsnn_nn_retries;
 };
 
+/*
+ * VPort SCN State Machine events
+ */
+enum port_scn_event {
+	SCNSM_EVENT_PORT_ONLINE = 1,
+	SCNSM_EVENT_PORT_OFFLINE = 2,
+	SCNSM_EVENT_RSP_OK = 3,
+	SCNSM_EVENT_RSP_ERROR = 4,
+	SCNSM_EVENT_TIMEOUT = 5,
+	SCNSM_EVENT_SCR_SENT = 6,
+};
+
+struct bfa_fcs_lport_scn_s;
+typedef void (*bfa_fcs_lport_scn_sm_t)(struct bfa_fcs_lport_scn_s *fsm, enum port_scn_event);
 
 struct bfa_fcs_lport_scn_s {
-	bfa_sm_t        sm;		/*  state machine */
+	bfa_fcs_lport_scn_sm_t sm;	/*  state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_s *port;	/*  parent port */
 	struct bfa_fcxp_s *fcxp;
@@ -79,8 +99,25 @@ struct bfa_fcs_lport_scn_s {
 };
 
 
+/*
+ *  FDMI State Machine events
+ */
+enum port_fdmi_event {
+	FDMISM_EVENT_PORT_ONLINE = 1,
+	FDMISM_EVENT_PORT_OFFLINE = 2,
+	FDMISM_EVENT_RSP_OK = 4,
+	FDMISM_EVENT_RSP_ERROR = 5,
+	FDMISM_EVENT_TIMEOUT = 6,
+	FDMISM_EVENT_RHBA_SENT = 7,
+	FDMISM_EVENT_RPRT_SENT = 8,
+	FDMISM_EVENT_RPA_SENT = 9,
+};
+
+struct bfa_fcs_lport_fdmi_s;
+typedef void (*bfa_fcs_lport_fdmi_sm_t)(struct bfa_fcs_lport_fdmi_s *fsm, enum port_fdmi_event);
+
 struct bfa_fcs_lport_fdmi_s {
-	bfa_sm_t        sm;		/*  state machine */
+	bfa_fcs_lport_fdmi_sm_t sm;		/*  state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_ms_s *ms;	/*  parent ms */
 	struct bfa_fcxp_s *fcxp;
@@ -88,10 +125,24 @@ struct bfa_fcs_lport_fdmi_s {
 	u8	retry_cnt;	/*  retry count */
 	u8	rsvd[3];
 };
+/*
+ *  MS State Machine events
+ */
+enum port_ms_event {
+	MSSM_EVENT_PORT_ONLINE = 1,
+	MSSM_EVENT_PORT_OFFLINE = 2,
+	MSSM_EVENT_RSP_OK = 3,
+	MSSM_EVENT_RSP_ERROR = 4,
+	MSSM_EVENT_TIMEOUT = 5,
+	MSSM_EVENT_FCXP_SENT = 6,
+	MSSM_EVENT_PORT_FABRIC_RSCN = 7
+};
 
+struct bfa_fcs_lport_ms_s;
+typedef void (*bfa_fcs_lport_ms_sm_t)(struct bfa_fcs_lport_ms_s *fsm, enum port_ms_event);
 
 struct bfa_fcs_lport_ms_s {
-	bfa_sm_t        sm;		/*  state machine */
+	bfa_fcs_lport_ms_sm_t        sm;		/*  state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_s *port;	/*  parent port */
 	struct bfa_fcxp_s *fcxp;
@@ -131,10 +182,25 @@ union bfa_fcs_lport_topo_u {
 	struct bfa_fcs_lport_n2n_s pn2n;
 };
 
+/*
+ *  fcs_port_sm FCS logical port state machine
+ */
+
+enum bfa_fcs_lport_event {
+	BFA_FCS_PORT_SM_CREATE = 1,
+	BFA_FCS_PORT_SM_ONLINE = 2,
+	BFA_FCS_PORT_SM_OFFLINE = 3,
+	BFA_FCS_PORT_SM_DELETE = 4,
+	BFA_FCS_PORT_SM_DELRPORT = 5,
+	BFA_FCS_PORT_SM_STOP = 6,
+};
+
+struct bfa_fcs_lport_s;
+typedef void (*bfa_fcs_lport_sm_t)(struct bfa_fcs_lport_s *fsm, enum bfa_fcs_lport_event);
 
 struct bfa_fcs_lport_s {
 	struct list_head         qe;	/*  used by port/vport */
-	bfa_sm_t               sm;	/*  state machine */
+	bfa_fcs_lport_sm_t       sm;	/*  state machine */
 	struct bfa_fcs_fabric_s *fabric;	/*  parent fabric */
 	struct bfa_lport_cfg_s  port_cfg;	/*  port configuration */
 	struct bfa_timer_s link_timer;	/*  timer for link offline */
@@ -171,10 +237,37 @@ enum bfa_fcs_fabric_type {
 	BFA_FCS_FABRIC_LOOP = 3,
 };
 
+/*
+ * Fabric state machine events
+ */
+enum bfa_fcs_fabric_event {
+	BFA_FCS_FABRIC_SM_CREATE        = 1,    /*  create from driver        */
+	BFA_FCS_FABRIC_SM_DELETE        = 2,    /*  delete from driver        */
+	BFA_FCS_FABRIC_SM_LINK_DOWN     = 3,    /*  link down from port      */
+	BFA_FCS_FABRIC_SM_LINK_UP       = 4,    /*  link up from port         */
+	BFA_FCS_FABRIC_SM_CONT_OP       = 5,    /*  flogi/auth continue op   */
+	BFA_FCS_FABRIC_SM_RETRY_OP      = 6,    /*  flogi/auth retry op      */
+	BFA_FCS_FABRIC_SM_NO_FABRIC     = 7,    /*  from flogi/auth           */
+	BFA_FCS_FABRIC_SM_PERF_EVFP     = 8,    /*  from flogi/auth           */
+	BFA_FCS_FABRIC_SM_ISOLATE       = 9,    /*  from EVFP processing     */
+	BFA_FCS_FABRIC_SM_NO_TAGGING    = 10,   /*  no VFT tagging from EVFP */
+	BFA_FCS_FABRIC_SM_DELAYED       = 11,   /*  timeout delay event      */
+	BFA_FCS_FABRIC_SM_AUTH_FAILED   = 12,   /*  auth failed       */
+	BFA_FCS_FABRIC_SM_AUTH_SUCCESS  = 13,   /*  auth successful           */
+	BFA_FCS_FABRIC_SM_DELCOMP       = 14,   /*  all vports deleted event */
+	BFA_FCS_FABRIC_SM_LOOPBACK      = 15,   /*  Received our own FLOGI   */
+	BFA_FCS_FABRIC_SM_START         = 16,   /*  from driver       */
+	BFA_FCS_FABRIC_SM_STOP		= 17,	/*  Stop from driver	*/
+	BFA_FCS_FABRIC_SM_STOPCOMP	= 18,	/*  Stop completion	*/
+	BFA_FCS_FABRIC_SM_LOGOCOMP	= 19,	/*  FLOGO completion	*/
+};
+
+struct bfa_fcs_fabric_s;
+typedef void (*bfa_fcs_fabric_sm_t)(struct bfa_fcs_fabric_s *fsm, enum bfa_fcs_fabric_event);
 
 struct bfa_fcs_fabric_s {
 	struct list_head   qe;		/*  queue element */
-	bfa_sm_t	 sm;		/*  state machine */
+	bfa_fcs_fabric_sm_t	 sm;	/*  state machine */
 	struct bfa_fcs_s *fcs;		/*  FCS instance */
 	struct bfa_fcs_lport_s  bport;	/*  base logical port */
 	enum bfa_fcs_fabric_type fab_type; /*  fabric type */
@@ -344,9 +437,33 @@ void            bfa_fcs_lport_scn_process_rscn(struct bfa_fcs_lport_s *port,
 					      struct fchs_s *rx_frame, u32 len);
 void		bfa_fcs_lport_lip_scn_online(bfa_fcs_lport_t *port);
 
+/*
+ * VPort State Machine events
+ */
+enum bfa_fcs_vport_event {
+	BFA_FCS_VPORT_SM_CREATE = 1,	/*  vport create event */
+	BFA_FCS_VPORT_SM_DELETE = 2,	/*  vport delete event */
+	BFA_FCS_VPORT_SM_START = 3,	/*  vport start request */
+	BFA_FCS_VPORT_SM_STOP = 4,	/*  stop: unsupported */
+	BFA_FCS_VPORT_SM_ONLINE = 5,	/*  fabric online */
+	BFA_FCS_VPORT_SM_OFFLINE = 6,	/*  fabric offline event */
+	BFA_FCS_VPORT_SM_FRMSENT = 7,	/*  fdisc/logo sent events */
+	BFA_FCS_VPORT_SM_RSP_OK = 8,	/*  good response */
+	BFA_FCS_VPORT_SM_RSP_ERROR = 9,	/*  error/bad response */
+	BFA_FCS_VPORT_SM_TIMEOUT = 10,	/*  delay timer event */
+	BFA_FCS_VPORT_SM_DELCOMP = 11,	/*  lport delete completion */
+	BFA_FCS_VPORT_SM_RSP_DUP_WWN = 12,	/*  Dup wnn error*/
+	BFA_FCS_VPORT_SM_RSP_FAILED = 13,	/*  non-retryable failure */
+	BFA_FCS_VPORT_SM_STOPCOMP = 14,	/* vport delete completion */
+	BFA_FCS_VPORT_SM_FABRIC_MAX = 15, /* max vports on fabric */
+};
+
+struct bfa_fcs_vport_s;
+typedef void (*bfa_fcs_vport_sm_t)(struct bfa_fcs_vport_s *fsm, enum bfa_fcs_vport_event);
+
 struct bfa_fcs_vport_s {
 	struct list_head		qe;		/*  queue elem	*/
-	bfa_sm_t		sm;		/*  state machine	*/
+	bfa_fcs_vport_sm_t		sm;		/*  state machine	*/
 	bfa_fcs_lport_t		lport;		/*  logical port	*/
 	struct bfa_timer_s	timer;
 	struct bfad_vport_s	*vport_drv;	/*  Driver private	*/
@@ -397,9 +514,26 @@ struct bfa_fcs_itnim_s;
 struct bfa_fcs_tin_s;
 struct bfa_fcs_iprp_s;
 
+/*
+ *  fcs_rport_ftrs_sm FCS rport state machine events
+ */
+
+enum rpf_event {
+	RPFSM_EVENT_RPORT_OFFLINE  = 1, /* Rport offline		*/
+	RPFSM_EVENT_RPORT_ONLINE   = 2,	/* Rport online			*/
+	RPFSM_EVENT_FCXP_SENT      = 3,	/* Frame from has been sent	*/
+	RPFSM_EVENT_TIMEOUT	   = 4, /* Rport SM timeout event	*/
+	RPFSM_EVENT_RPSC_COMP      = 5,
+	RPFSM_EVENT_RPSC_FAIL      = 6,
+	RPFSM_EVENT_RPSC_ERROR     = 7,
+};
+
+struct bfa_fcs_rpf_s;
+typedef void (*bfa_fcs_rpf_sm_t)(struct bfa_fcs_rpf_s *, enum rpf_event);
+
 /* Rport Features (RPF) */
 struct bfa_fcs_rpf_s {
-	bfa_sm_t	sm;	/*  state machine */
+	bfa_fcs_rpf_sm_t	sm;	/*  state machine */
 	struct bfa_fcs_rport_s *rport;	/*  parent rport */
 	struct bfa_timer_s	timer;	/*  general purpose timer */
 	struct bfa_fcxp_s	*fcxp;	/*  FCXP needed for discarding */
@@ -414,6 +548,36 @@ struct bfa_fcs_rpf_s {
 	 */
 };
 
+/*
+ *  fcs_rport_sm FCS rport state machine events
+ */
+enum rport_event {
+	RPSM_EVENT_PLOGI_SEND   = 1,    /*  new rport; start with PLOGI */
+	RPSM_EVENT_PLOGI_RCVD   = 2,    /*  Inbound PLOGI from remote port */
+	RPSM_EVENT_PLOGI_COMP   = 3,    /*  PLOGI completed to rport    */
+	RPSM_EVENT_LOGO_RCVD    = 4,    /*  LOGO from remote device     */
+	RPSM_EVENT_LOGO_IMP     = 5,    /*  implicit logo for SLER      */
+	RPSM_EVENT_FCXP_SENT    = 6,    /*  Frame from has been sent    */
+	RPSM_EVENT_DELETE       = 7,    /*  RPORT delete request        */
+	RPSM_EVENT_FAB_SCN	= 8,    /*  state change notification   */
+	RPSM_EVENT_ACCEPTED     = 9,    /*  Good response from remote device */
+	RPSM_EVENT_FAILED       = 10,   /*  Request to rport failed.    */
+	RPSM_EVENT_TIMEOUT      = 11,   /*  Rport SM timeout event      */
+	RPSM_EVENT_HCB_ONLINE  = 12,    /*  BFA rport online callback   */
+	RPSM_EVENT_HCB_OFFLINE = 13,    /*  BFA rport offline callback  */
+	RPSM_EVENT_FC4_OFFLINE = 14,    /*  FC-4 offline complete       */
+	RPSM_EVENT_ADDRESS_CHANGE = 15, /*  Rport's PID has changed     */
+	RPSM_EVENT_ADDRESS_DISC = 16,   /*  Need to Discover rport's PID */
+	RPSM_EVENT_PRLO_RCVD   = 17,    /*  PRLO from remote device     */
+	RPSM_EVENT_PLOGI_RETRY = 18,    /*  Retry PLOGI continuously */
+	RPSM_EVENT_SCN_OFFLINE = 19,	/* loop scn offline		*/
+	RPSM_EVENT_SCN_ONLINE   = 20,	/* loop scn online		*/
+	RPSM_EVENT_FC4_FCS_ONLINE = 21, /* FC-4 FCS online complete */
+};
+
+struct bfa_fcs_rport_s;
+typedef void (*bfa_fcs_rport_sm_t)(struct bfa_fcs_rport_s *, enum rport_event);
+
 struct bfa_fcs_rport_s {
 	struct list_head	qe;	/*  used by port/vport */
 	struct bfa_fcs_lport_s *port;	/*  parent FCS port */
@@ -430,7 +594,7 @@ struct bfa_fcs_rport_s {
 	wwn_t	pwwn;	/*  port wwn of rport */
 	wwn_t	nwwn;	/*  node wwn of rport */
 	struct bfa_rport_symname_s psym_name; /*  port symbolic name  */
-	bfa_sm_t	sm;		/*  state machine */
+	bfa_fcs_rport_sm_t	sm;	/*  state machine */
 	struct bfa_timer_s timer;	/*  general purpose timer */
 	struct bfa_fcs_itnim_s *itnim;	/*  ITN initiator mode role */
 	struct bfa_fcs_tin_s *tin;	/*  ITN initiator mode role */
@@ -487,13 +651,35 @@ void  bfa_fcs_rpf_init(struct bfa_fcs_rport_s *rport);
 void  bfa_fcs_rpf_rport_online(struct bfa_fcs_rport_s *rport);
 void  bfa_fcs_rpf_rport_offline(struct bfa_fcs_rport_s *rport);
 
+/*
+ * fcs_itnim_sm FCS itnim state machine events
+ */
+enum bfa_fcs_itnim_event {
+	BFA_FCS_ITNIM_SM_FCS_ONLINE = 1,        /*  rport online event */
+	BFA_FCS_ITNIM_SM_OFFLINE = 2,   /*  rport offline */
+	BFA_FCS_ITNIM_SM_FRMSENT = 3,   /*  prli frame is sent */
+	BFA_FCS_ITNIM_SM_RSP_OK = 4,    /*  good response */
+	BFA_FCS_ITNIM_SM_RSP_ERROR = 5, /*  error response */
+	BFA_FCS_ITNIM_SM_TIMEOUT = 6,   /*  delay timeout */
+	BFA_FCS_ITNIM_SM_HCB_OFFLINE = 7, /*  BFA online callback */
+	BFA_FCS_ITNIM_SM_HCB_ONLINE = 8, /*  BFA offline callback */
+	BFA_FCS_ITNIM_SM_INITIATOR = 9, /*  rport is initiator */
+	BFA_FCS_ITNIM_SM_DELETE = 10,   /*  delete event from rport */
+	BFA_FCS_ITNIM_SM_PRLO = 11,     /*  delete event from rport */
+	BFA_FCS_ITNIM_SM_RSP_NOT_SUPP = 12, /* cmd not supported rsp */
+	BFA_FCS_ITNIM_SM_HAL_ONLINE = 13, /* bfa rport online event */
+};
+
+struct bfa_fcs_itnim_s;
+typedef void (*bfa_fcs_itnim_sm_t)(struct bfa_fcs_itnim_s *, enum bfa_fcs_itnim_event);
+
 /*
  * forward declarations
  */
 struct bfad_itnim_s;
 
 struct bfa_fcs_itnim_s {
-	bfa_sm_t		sm;		/*  state machine */
+	bfa_fcs_itnim_sm_t	sm;		/*  state machine */
 	struct bfa_fcs_rport_s	*rport;		/*  parent remote rport  */
 	struct bfad_itnim_s	*itnim_drv;	/*  driver peer instance */
 	struct bfa_fcs_s	*fcs;		/*  fcs instance	*/
@@ -702,78 +888,6 @@ struct bfa_fcs_s {
  *  fcs_fabric_sm fabric state machine functions
  */
 
-/*
- * Fabric state machine events
- */
-enum bfa_fcs_fabric_event {
-	BFA_FCS_FABRIC_SM_CREATE        = 1,    /*  create from driver        */
-	BFA_FCS_FABRIC_SM_DELETE        = 2,    /*  delete from driver        */
-	BFA_FCS_FABRIC_SM_LINK_DOWN     = 3,    /*  link down from port      */
-	BFA_FCS_FABRIC_SM_LINK_UP       = 4,    /*  link up from port         */
-	BFA_FCS_FABRIC_SM_CONT_OP       = 5,    /*  flogi/auth continue op   */
-	BFA_FCS_FABRIC_SM_RETRY_OP      = 6,    /*  flogi/auth retry op      */
-	BFA_FCS_FABRIC_SM_NO_FABRIC     = 7,    /*  from flogi/auth           */
-	BFA_FCS_FABRIC_SM_PERF_EVFP     = 8,    /*  from flogi/auth           */
-	BFA_FCS_FABRIC_SM_ISOLATE       = 9,    /*  from EVFP processing     */
-	BFA_FCS_FABRIC_SM_NO_TAGGING    = 10,   /*  no VFT tagging from EVFP */
-	BFA_FCS_FABRIC_SM_DELAYED       = 11,   /*  timeout delay event      */
-	BFA_FCS_FABRIC_SM_AUTH_FAILED   = 12,   /*  auth failed       */
-	BFA_FCS_FABRIC_SM_AUTH_SUCCESS  = 13,   /*  auth successful           */
-	BFA_FCS_FABRIC_SM_DELCOMP       = 14,   /*  all vports deleted event */
-	BFA_FCS_FABRIC_SM_LOOPBACK      = 15,   /*  Received our own FLOGI   */
-	BFA_FCS_FABRIC_SM_START         = 16,   /*  from driver       */
-	BFA_FCS_FABRIC_SM_STOP		= 17,	/*  Stop from driver	*/
-	BFA_FCS_FABRIC_SM_STOPCOMP	= 18,	/*  Stop completion	*/
-	BFA_FCS_FABRIC_SM_LOGOCOMP	= 19,	/*  FLOGO completion	*/
-};
-
-/*
- *  fcs_rport_sm FCS rport state machine events
- */
-
-enum rport_event {
-	RPSM_EVENT_PLOGI_SEND   = 1,    /*  new rport; start with PLOGI */
-	RPSM_EVENT_PLOGI_RCVD   = 2,    /*  Inbound PLOGI from remote port */
-	RPSM_EVENT_PLOGI_COMP   = 3,    /*  PLOGI completed to rport    */
-	RPSM_EVENT_LOGO_RCVD    = 4,    /*  LOGO from remote device     */
-	RPSM_EVENT_LOGO_IMP     = 5,    /*  implicit logo for SLER      */
-	RPSM_EVENT_FCXP_SENT    = 6,    /*  Frame from has been sent    */
-	RPSM_EVENT_DELETE       = 7,    /*  RPORT delete request        */
-	RPSM_EVENT_FAB_SCN	= 8,    /*  state change notification   */
-	RPSM_EVENT_ACCEPTED     = 9,    /*  Good response from remote device */
-	RPSM_EVENT_FAILED       = 10,   /*  Request to rport failed.    */
-	RPSM_EVENT_TIMEOUT      = 11,   /*  Rport SM timeout event      */
-	RPSM_EVENT_HCB_ONLINE  = 12,    /*  BFA rport online callback   */
-	RPSM_EVENT_HCB_OFFLINE = 13,    /*  BFA rport offline callback  */
-	RPSM_EVENT_FC4_OFFLINE = 14,    /*  FC-4 offline complete       */
-	RPSM_EVENT_ADDRESS_CHANGE = 15, /*  Rport's PID has changed     */
-	RPSM_EVENT_ADDRESS_DISC = 16,   /*  Need to Discover rport's PID */
-	RPSM_EVENT_PRLO_RCVD   = 17,    /*  PRLO from remote device     */
-	RPSM_EVENT_PLOGI_RETRY = 18,    /*  Retry PLOGI continuously */
-	RPSM_EVENT_SCN_OFFLINE = 19,	/* loop scn offline		*/
-	RPSM_EVENT_SCN_ONLINE   = 20,	/* loop scn online		*/
-	RPSM_EVENT_FC4_FCS_ONLINE = 21, /* FC-4 FCS online complete */
-};
-
-/*
- * fcs_itnim_sm FCS itnim state machine events
- */
-enum bfa_fcs_itnim_event {
-	BFA_FCS_ITNIM_SM_FCS_ONLINE = 1,        /*  rport online event */
-	BFA_FCS_ITNIM_SM_OFFLINE = 2,   /*  rport offline */
-	BFA_FCS_ITNIM_SM_FRMSENT = 3,   /*  prli frame is sent */
-	BFA_FCS_ITNIM_SM_RSP_OK = 4,    /*  good response */
-	BFA_FCS_ITNIM_SM_RSP_ERROR = 5, /*  error response */
-	BFA_FCS_ITNIM_SM_TIMEOUT = 6,   /*  delay timeout */
-	BFA_FCS_ITNIM_SM_HCB_OFFLINE = 7, /*  BFA online callback */
-	BFA_FCS_ITNIM_SM_HCB_ONLINE = 8, /*  BFA offline callback */
-	BFA_FCS_ITNIM_SM_INITIATOR = 9, /*  rport is initiator */
-	BFA_FCS_ITNIM_SM_DELETE = 10,   /*  delete event from rport */
-	BFA_FCS_ITNIM_SM_PRLO = 11,     /*  delete event from rport */
-	BFA_FCS_ITNIM_SM_RSP_NOT_SUPP = 12, /* cmd not supported rsp */
-	BFA_FCS_ITNIM_SM_HAL_ONLINE = 13, /* bfa rport online event */
-};
-
 /*
  * bfa fcs API functions
  */
diff --git a/drivers/scsi/bfa/bfa_fcs_fcpim.c b/drivers/scsi/bfa/bfa_fcs_fcpim.c
index c7de62baeec99..40e65ab285040 100644
--- a/drivers/scsi/bfa/bfa_fcs_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcs_fcpim.c
@@ -16,6 +16,7 @@
 #include "bfa_fcs.h"
 #include "bfa_fcbuild.h"
 #include "bfad_im.h"
+#include "bfa_fcpim.h"
 
 BFA_TRC_FILE(FCS, FCPIM);
 
@@ -52,7 +53,23 @@ static void	bfa_fcs_itnim_sm_hcb_offline(struct bfa_fcs_itnim_s *itnim,
 static void	bfa_fcs_itnim_sm_initiator(struct bfa_fcs_itnim_s *itnim,
 					   enum bfa_fcs_itnim_event event);
 
-static struct bfa_sm_table_s itnim_sm_table[] = {
+struct bfa_fcs_itnim_sm_table_s {
+	bfa_fcs_itnim_sm_t sm;		/*  state machine function	*/
+	enum bfa_itnim_state state;	/*  state machine encoding	*/
+	char		*name;		/*  state name for display	*/
+};
+
+static inline enum bfa_itnim_state
+bfa_fcs_itnim_sm_to_state(struct bfa_fcs_itnim_sm_table_s *smt, bfa_fcs_itnim_sm_t sm)
+{
+	int i = 0;
+
+	while (smt[i].sm && smt[i].sm != sm)
+		i++;
+	return smt[i].state;
+}
+
+static struct bfa_fcs_itnim_sm_table_s itnim_sm_table[] = {
 	{BFA_SM(bfa_fcs_itnim_sm_offline), BFA_ITNIM_OFFLINE},
 	{BFA_SM(bfa_fcs_itnim_sm_prli_send), BFA_ITNIM_PRLI_SEND},
 	{BFA_SM(bfa_fcs_itnim_sm_prli), BFA_ITNIM_PRLI_SENT},
@@ -665,7 +682,7 @@ bfa_status_t
 bfa_fcs_itnim_get_online_state(struct bfa_fcs_itnim_s *itnim)
 {
 	bfa_trc(itnim->fcs, itnim->rport->pid);
-	switch (bfa_sm_to_state(itnim_sm_table, itnim->sm)) {
+	switch (bfa_fcs_itnim_sm_to_state(itnim_sm_table, itnim->sm)) {
 	case BFA_ITNIM_ONLINE:
 	case BFA_ITNIM_INITIATIOR:
 		return BFA_STATUS_OK;
@@ -765,7 +782,7 @@ bfa_fcs_itnim_attr_get(struct bfa_fcs_lport_s *port, wwn_t rpwwn,
 	if (itnim == NULL)
 		return BFA_STATUS_NO_FCPIM_NEXUS;
 
-	attr->state	    = bfa_sm_to_state(itnim_sm_table, itnim->sm);
+	attr->state	    = bfa_fcs_itnim_sm_to_state(itnim_sm_table, itnim->sm);
 	attr->retry	    = itnim->seq_rec;
 	attr->rec_support   = itnim->rec_support;
 	attr->conf_comp	    = itnim->conf_comp;
diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
index 008afd8170871..966bf6cc6dd90 100644
--- a/drivers/scsi/bfa/bfa_fcs_lport.c
+++ b/drivers/scsi/bfa/bfa_fcs_lport.c
@@ -103,19 +103,6 @@ static struct {
 	},
 };
 
-/*
- *  fcs_port_sm FCS logical port state machine
- */
-
-enum bfa_fcs_lport_event {
-	BFA_FCS_PORT_SM_CREATE = 1,
-	BFA_FCS_PORT_SM_ONLINE = 2,
-	BFA_FCS_PORT_SM_OFFLINE = 3,
-	BFA_FCS_PORT_SM_DELETE = 4,
-	BFA_FCS_PORT_SM_DELRPORT = 5,
-	BFA_FCS_PORT_SM_STOP = 6,
-};
-
 static void     bfa_fcs_lport_sm_uninit(struct bfa_fcs_lport_s *port,
 					enum bfa_fcs_lport_event event);
 static void     bfa_fcs_lport_sm_init(struct bfa_fcs_lport_s *port,
@@ -1426,20 +1413,6 @@ u32	bfa_fcs_fdmi_convert_speed(enum bfa_port_speed pport_speed);
  *  fcs_fdmi_sm FCS FDMI state machine
  */
 
-/*
- *  FDMI State Machine events
- */
-enum port_fdmi_event {
-	FDMISM_EVENT_PORT_ONLINE = 1,
-	FDMISM_EVENT_PORT_OFFLINE = 2,
-	FDMISM_EVENT_RSP_OK = 4,
-	FDMISM_EVENT_RSP_ERROR = 5,
-	FDMISM_EVENT_TIMEOUT = 6,
-	FDMISM_EVENT_RHBA_SENT = 7,
-	FDMISM_EVENT_RPRT_SENT = 8,
-	FDMISM_EVENT_RPA_SENT = 9,
-};
-
 static void     bfa_fcs_lport_fdmi_sm_offline(struct bfa_fcs_lport_fdmi_s *fdmi,
 					     enum port_fdmi_event event);
 static void     bfa_fcs_lport_fdmi_sm_sending_rhba(
@@ -2863,19 +2836,6 @@ static void     bfa_fcs_lport_ms_gfn_response(void *fcsarg,
  *  fcs_ms_sm FCS MS state machine
  */
 
-/*
- *  MS State Machine events
- */
-enum port_ms_event {
-	MSSM_EVENT_PORT_ONLINE = 1,
-	MSSM_EVENT_PORT_OFFLINE = 2,
-	MSSM_EVENT_RSP_OK = 3,
-	MSSM_EVENT_RSP_ERROR = 4,
-	MSSM_EVENT_TIMEOUT = 5,
-	MSSM_EVENT_FCXP_SENT = 6,
-	MSSM_EVENT_PORT_FABRIC_RSCN = 7
-};
-
 static void     bfa_fcs_lport_ms_sm_offline(struct bfa_fcs_lport_ms_s *ms,
 					   enum port_ms_event event);
 static void     bfa_fcs_lport_ms_sm_plogi_sending(struct bfa_fcs_lport_ms_s *ms,
@@ -3644,25 +3604,6 @@ static void bfa_fcs_lport_ns_boot_target_disc(bfa_fcs_lport_t *port);
  *  fcs_ns_sm FCS nameserver interface state machine
  */
 
-/*
- * VPort NS State Machine events
- */
-enum vport_ns_event {
-	NSSM_EVENT_PORT_ONLINE = 1,
-	NSSM_EVENT_PORT_OFFLINE = 2,
-	NSSM_EVENT_PLOGI_SENT = 3,
-	NSSM_EVENT_RSP_OK = 4,
-	NSSM_EVENT_RSP_ERROR = 5,
-	NSSM_EVENT_TIMEOUT = 6,
-	NSSM_EVENT_NS_QUERY = 7,
-	NSSM_EVENT_RSPNID_SENT = 8,
-	NSSM_EVENT_RFTID_SENT = 9,
-	NSSM_EVENT_RFFID_SENT = 10,
-	NSSM_EVENT_GIDFT_SENT = 11,
-	NSSM_EVENT_RNNID_SENT = 12,
-	NSSM_EVENT_RSNN_NN_SENT = 13,
-};
-
 static void     bfa_fcs_lport_ns_sm_offline(struct bfa_fcs_lport_ns_s *ns,
 					   enum vport_ns_event event);
 static void     bfa_fcs_lport_ns_sm_plogi_sending(struct bfa_fcs_lport_ns_s *ns,
@@ -5239,18 +5180,6 @@ static void     bfa_fcs_lport_scn_timeout(void *arg);
  *  fcs_scm_sm FCS SCN state machine
  */
 
-/*
- * VPort SCN State Machine events
- */
-enum port_scn_event {
-	SCNSM_EVENT_PORT_ONLINE = 1,
-	SCNSM_EVENT_PORT_OFFLINE = 2,
-	SCNSM_EVENT_RSP_OK = 3,
-	SCNSM_EVENT_RSP_ERROR = 4,
-	SCNSM_EVENT_TIMEOUT = 5,
-	SCNSM_EVENT_SCR_SENT = 6,
-};
-
 static void     bfa_fcs_lport_scn_sm_offline(struct bfa_fcs_lport_scn_s *scn,
 					    enum port_scn_event event);
 static void     bfa_fcs_lport_scn_sm_sending_scr(
@@ -5989,27 +5918,6 @@ static void     bfa_fcs_vport_free(struct bfa_fcs_vport_s *vport);
  *  fcs_vport_sm FCS virtual port state machine
  */
 
-/*
- * VPort State Machine events
- */
-enum bfa_fcs_vport_event {
-	BFA_FCS_VPORT_SM_CREATE = 1,	/*  vport create event */
-	BFA_FCS_VPORT_SM_DELETE = 2,	/*  vport delete event */
-	BFA_FCS_VPORT_SM_START = 3,	/*  vport start request */
-	BFA_FCS_VPORT_SM_STOP = 4,	/*  stop: unsupported */
-	BFA_FCS_VPORT_SM_ONLINE = 5,	/*  fabric online */
-	BFA_FCS_VPORT_SM_OFFLINE = 6,	/*  fabric offline event */
-	BFA_FCS_VPORT_SM_FRMSENT = 7,	/*  fdisc/logo sent events */
-	BFA_FCS_VPORT_SM_RSP_OK = 8,	/*  good response */
-	BFA_FCS_VPORT_SM_RSP_ERROR = 9,	/*  error/bad response */
-	BFA_FCS_VPORT_SM_TIMEOUT = 10,	/*  delay timer event */
-	BFA_FCS_VPORT_SM_DELCOMP = 11,	/*  lport delete completion */
-	BFA_FCS_VPORT_SM_RSP_DUP_WWN = 12,	/*  Dup wnn error*/
-	BFA_FCS_VPORT_SM_RSP_FAILED = 13,	/*  non-retryable failure */
-	BFA_FCS_VPORT_SM_STOPCOMP = 14,	/* vport delete completion */
-	BFA_FCS_VPORT_SM_FABRIC_MAX = 15, /* max vports on fabric */
-};
-
 static void     bfa_fcs_vport_sm_uninit(struct bfa_fcs_vport_s *vport,
 					enum bfa_fcs_vport_event event);
 static void     bfa_fcs_vport_sm_created(struct bfa_fcs_vport_s *vport,
@@ -6037,7 +5945,23 @@ static void	bfa_fcs_vport_sm_stopping(struct bfa_fcs_vport_s *vport,
 static void	bfa_fcs_vport_sm_logo_for_stop(struct bfa_fcs_vport_s *vport,
 					enum bfa_fcs_vport_event event);
 
-static struct bfa_sm_table_s  vport_sm_table[] = {
+struct bfa_fcs_vport_sm_table_s {
+	bfa_fcs_vport_sm_t sm;		/*  state machine function	*/
+	enum bfa_vport_state state;	/*  state machine encoding	*/
+	char		*name;		/*  state name for display	*/
+};
+
+static inline enum bfa_vport_state
+bfa_vport_sm_to_state(struct bfa_fcs_vport_sm_table_s *smt, bfa_fcs_vport_sm_t sm)
+{
+	int i = 0;
+
+	while (smt[i].sm && smt[i].sm != sm)
+		i++;
+	return smt[i].state;
+}
+
+static struct bfa_fcs_vport_sm_table_s  vport_sm_table[] = {
 	{BFA_SM(bfa_fcs_vport_sm_uninit), BFA_FCS_VPORT_UNINIT},
 	{BFA_SM(bfa_fcs_vport_sm_created), BFA_FCS_VPORT_CREATED},
 	{BFA_SM(bfa_fcs_vport_sm_offline), BFA_FCS_VPORT_OFFLINE},
@@ -6864,7 +6788,7 @@ bfa_fcs_vport_get_attr(struct bfa_fcs_vport_s *vport,
 	memset(attr, 0, sizeof(struct bfa_vport_attr_s));
 
 	bfa_fcs_lport_get_attr(&vport->lport, &attr->port_attr);
-	attr->vport_state = bfa_sm_to_state(vport_sm_table, vport->sm);
+	attr->vport_state = bfa_vport_sm_to_state(vport_sm_table, vport->sm);
 }
 
 
diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rport.c
index c21aa37b8adbe..ce52a9c88ae63 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -136,7 +136,23 @@ static void	bfa_fcs_rport_sm_fc4_off_delete(struct bfa_fcs_rport_s *rport,
 static void	bfa_fcs_rport_sm_delete_pending(struct bfa_fcs_rport_s *rport,
 						enum rport_event event);
 
-static struct bfa_sm_table_s rport_sm_table[] = {
+struct bfa_fcs_rport_sm_table_s {
+	bfa_fcs_rport_sm_t sm;		/*  state machine function	*/
+	enum bfa_rport_state state;	/*  state machine encoding	*/
+	char		*name;		/*  state name for display	*/
+};
+
+static inline enum bfa_rport_state
+bfa_rport_sm_to_state(struct bfa_fcs_rport_sm_table_s *smt, bfa_fcs_rport_sm_t sm)
+{
+	int i = 0;
+
+	while (smt[i].sm && smt[i].sm != sm)
+		i++;
+	return smt[i].state;
+}
+
+static struct bfa_fcs_rport_sm_table_s rport_sm_table[] = {
 	{BFA_SM(bfa_fcs_rport_sm_uninit), BFA_RPORT_UNINIT},
 	{BFA_SM(bfa_fcs_rport_sm_plogi_sending), BFA_RPORT_PLOGI},
 	{BFA_SM(bfa_fcs_rport_sm_plogiacc_sending), BFA_RPORT_ONLINE},
@@ -2964,7 +2980,7 @@ bfa_fcs_rport_send_ls_rjt(struct bfa_fcs_rport_s *rport, struct fchs_s *rx_fchs,
 int
 bfa_fcs_rport_get_state(struct bfa_fcs_rport_s *rport)
 {
-	return bfa_sm_to_state(rport_sm_table, rport->sm);
+	return bfa_rport_sm_to_state(rport_sm_table, rport->sm);
 }
 
 
@@ -3107,20 +3123,6 @@ static void     bfa_fcs_rpf_rpsc2_response(void *fcsarg,
 
 static void     bfa_fcs_rpf_timeout(void *arg);
 
-/*
- *  fcs_rport_ftrs_sm FCS rport state machine events
- */
-
-enum rpf_event {
-	RPFSM_EVENT_RPORT_OFFLINE  = 1, /* Rport offline		*/
-	RPFSM_EVENT_RPORT_ONLINE   = 2,	/* Rport online			*/
-	RPFSM_EVENT_FCXP_SENT      = 3,	/* Frame from has been sent	*/
-	RPFSM_EVENT_TIMEOUT	   = 4, /* Rport SM timeout event	*/
-	RPFSM_EVENT_RPSC_COMP      = 5,
-	RPFSM_EVENT_RPSC_FAIL      = 6,
-	RPFSM_EVENT_RPSC_ERROR     = 7,
-};
-
 static void	bfa_fcs_rpf_sm_uninit(struct bfa_fcs_rpf_s *rpf,
 					enum rpf_event event);
 static void     bfa_fcs_rpf_sm_rpsc_sending(struct bfa_fcs_rpf_s *rpf,
diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index e1ed1424fddb2..ea2f107f564cd 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -114,21 +114,6 @@ static enum bfi_ioc_img_ver_cmp_e bfa_ioc_flash_fwver_cmp(
 /*
  * IOC state machine definitions/declarations
  */
-enum ioc_event {
-	IOC_E_RESET		= 1,	/*  IOC reset request		*/
-	IOC_E_ENABLE		= 2,	/*  IOC enable request		*/
-	IOC_E_DISABLE		= 3,	/*  IOC disable request	*/
-	IOC_E_DETACH		= 4,	/*  driver detach cleanup	*/
-	IOC_E_ENABLED		= 5,	/*  f/w enabled		*/
-	IOC_E_FWRSP_GETATTR	= 6,	/*  IOC get attribute response	*/
-	IOC_E_DISABLED		= 7,	/*  f/w disabled		*/
-	IOC_E_PFFAILED		= 8,	/*  failure notice by iocpf sm	*/
-	IOC_E_HBFAIL		= 9,	/*  heartbeat failure		*/
-	IOC_E_HWERROR		= 10,	/*  hardware error interrupt	*/
-	IOC_E_TIMEOUT		= 11,	/*  timeout			*/
-	IOC_E_HWFAILED		= 12,	/*  PCI mapping failure notice	*/
-};
-
 bfa_fsm_state_decl(bfa_ioc, uninit, struct bfa_ioc_s, enum ioc_event);
 bfa_fsm_state_decl(bfa_ioc, reset, struct bfa_ioc_s, enum ioc_event);
 bfa_fsm_state_decl(bfa_ioc, enabling, struct bfa_ioc_s, enum ioc_event);
@@ -140,7 +125,13 @@ bfa_fsm_state_decl(bfa_ioc, disabling, struct bfa_ioc_s, enum ioc_event);
 bfa_fsm_state_decl(bfa_ioc, disabled, struct bfa_ioc_s, enum ioc_event);
 bfa_fsm_state_decl(bfa_ioc, hwfail, struct bfa_ioc_s, enum ioc_event);
 
-static struct bfa_sm_table_s ioc_sm_table[] = {
+struct bfa_ioc_sm_table {
+	bfa_ioc_sm_t	sm;		/*  state machine function	*/
+	enum bfa_ioc_state state;	/*  state machine encoding	*/
+	char		*name;		/*  state name for display	*/
+};
+
+static struct bfa_ioc_sm_table ioc_sm_table[] = {
 	{BFA_SM(bfa_ioc_sm_uninit), BFA_IOC_UNINIT},
 	{BFA_SM(bfa_ioc_sm_reset), BFA_IOC_RESET},
 	{BFA_SM(bfa_ioc_sm_enabling), BFA_IOC_ENABLING},
@@ -153,6 +144,16 @@ static struct bfa_sm_table_s ioc_sm_table[] = {
 	{BFA_SM(bfa_ioc_sm_hwfail), BFA_IOC_HWFAIL},
 };
 
+static inline enum bfa_ioc_state
+bfa_ioc_sm_to_state(struct bfa_ioc_sm_table *smt, bfa_ioc_sm_t sm)
+{
+	int	i = 0;
+
+	while (smt[i].sm && smt[i].sm != sm)
+		i++;
+	return smt[i].state;
+}
+
 /*
  * IOCPF state machine definitions/declarations
  */
@@ -178,24 +179,6 @@ static void bfa_iocpf_timeout(void *ioc_arg);
 static void bfa_iocpf_sem_timeout(void *ioc_arg);
 static void bfa_iocpf_poll_timeout(void *ioc_arg);
 
-/*
- * IOCPF state machine events
- */
-enum iocpf_event {
-	IOCPF_E_ENABLE		= 1,	/*  IOCPF enable request	*/
-	IOCPF_E_DISABLE		= 2,	/*  IOCPF disable request	*/
-	IOCPF_E_STOP		= 3,	/*  stop on driver detach	*/
-	IOCPF_E_FWREADY		= 4,	/*  f/w initialization done	*/
-	IOCPF_E_FWRSP_ENABLE	= 5,	/*  enable f/w response	*/
-	IOCPF_E_FWRSP_DISABLE	= 6,	/*  disable f/w response	*/
-	IOCPF_E_FAIL		= 7,	/*  failure notice by ioc sm	*/
-	IOCPF_E_INITFAIL	= 8,	/*  init fail notice by ioc sm	*/
-	IOCPF_E_GETATTRFAIL	= 9,	/*  init fail notice by ioc sm	*/
-	IOCPF_E_SEMLOCKED	= 10,	/*  h/w semaphore is locked	*/
-	IOCPF_E_TIMEOUT		= 11,	/*  f/w response timeout	*/
-	IOCPF_E_SEM_ERROR	= 12,	/*  h/w sem mapping error	*/
-};
-
 /*
  * IOCPF states
  */
@@ -228,7 +211,23 @@ bfa_fsm_state_decl(bfa_iocpf, disabling_sync, struct bfa_iocpf_s,
 						enum iocpf_event);
 bfa_fsm_state_decl(bfa_iocpf, disabled, struct bfa_iocpf_s, enum iocpf_event);
 
-static struct bfa_sm_table_s iocpf_sm_table[] = {
+struct bfa_iocpf_sm_table {
+	bfa_iocpf_sm_t	sm;		/*  state machine function	*/
+	enum bfa_iocpf_state state;	/*  state machine encoding	*/
+	char		*name;		/*  state name for display	*/
+};
+
+static inline enum bfa_iocpf_state
+bfa_iocpf_sm_to_state(struct bfa_iocpf_sm_table *smt, bfa_iocpf_sm_t sm)
+{
+	int	i = 0;
+
+	while (smt[i].sm && smt[i].sm != sm)
+		i++;
+	return smt[i].state;
+}
+
+static struct bfa_iocpf_sm_table iocpf_sm_table[] = {
 	{BFA_SM(bfa_iocpf_sm_reset), BFA_IOCPF_RESET},
 	{BFA_SM(bfa_iocpf_sm_fwcheck), BFA_IOCPF_FWMISMATCH},
 	{BFA_SM(bfa_iocpf_sm_mismatch), BFA_IOCPF_FWMISMATCH},
@@ -2815,12 +2814,12 @@ enum bfa_ioc_state
 bfa_ioc_get_state(struct bfa_ioc_s *ioc)
 {
 	enum bfa_iocpf_state iocpf_st;
-	enum bfa_ioc_state ioc_st = bfa_sm_to_state(ioc_sm_table, ioc->fsm);
+	enum bfa_ioc_state ioc_st = bfa_ioc_sm_to_state(ioc_sm_table, ioc->fsm);
 
 	if (ioc_st == BFA_IOC_ENABLING ||
 		ioc_st == BFA_IOC_FAIL || ioc_st == BFA_IOC_INITFAIL) {
 
-		iocpf_st = bfa_sm_to_state(iocpf_sm_table, ioc->iocpf.fsm);
+		iocpf_st = bfa_iocpf_sm_to_state(iocpf_sm_table, ioc->iocpf.fsm);
 
 		switch (iocpf_st) {
 		case BFA_IOCPF_SEMWAIT:
@@ -5805,18 +5804,6 @@ bfa_phy_intr(void *phyarg, struct bfi_mbmsg_s *msg)
 	}
 }
 
-/*
- * DCONF state machine events
- */
-enum bfa_dconf_event {
-	BFA_DCONF_SM_INIT		= 1,	/* dconf Init */
-	BFA_DCONF_SM_FLASH_COMP		= 2,	/* read/write to flash */
-	BFA_DCONF_SM_WR			= 3,	/* binding change, map */
-	BFA_DCONF_SM_TIMEOUT		= 4,	/* Start timer */
-	BFA_DCONF_SM_EXIT		= 5,	/* exit dconf module */
-	BFA_DCONF_SM_IOCDISABLE		= 6,	/* IOC disable event */
-};
-
 /* forward declaration of DCONF state machine */
 static void bfa_dconf_sm_uninit(struct bfa_dconf_mod_s *dconf,
 				enum bfa_dconf_event event);
diff --git a/drivers/scsi/bfa/bfa_ioc.h b/drivers/scsi/bfa/bfa_ioc.h
index 5e568d6d7b261..3ec10503caff9 100644
--- a/drivers/scsi/bfa/bfa_ioc.h
+++ b/drivers/scsi/bfa/bfa_ioc.h
@@ -260,6 +260,24 @@ struct bfa_ioc_cbfn_s {
 /*
  * IOC event notification mechanism.
  */
+enum ioc_event {
+	IOC_E_RESET		= 1,	/*  IOC reset request		*/
+	IOC_E_ENABLE		= 2,	/*  IOC enable request		*/
+	IOC_E_DISABLE		= 3,	/*  IOC disable request	*/
+	IOC_E_DETACH		= 4,	/*  driver detach cleanup	*/
+	IOC_E_ENABLED		= 5,	/*  f/w enabled		*/
+	IOC_E_FWRSP_GETATTR	= 6,	/*  IOC get attribute response	*/
+	IOC_E_DISABLED		= 7,	/*  f/w disabled		*/
+	IOC_E_PFFAILED		= 8,	/*  failure notice by iocpf sm	*/
+	IOC_E_HBFAIL		= 9,	/*  heartbeat failure		*/
+	IOC_E_HWERROR		= 10,	/*  hardware error interrupt	*/
+	IOC_E_TIMEOUT		= 11,	/*  timeout			*/
+	IOC_E_HWFAILED		= 12,	/*  PCI mapping failure notice	*/
+};
+
+struct bfa_ioc_s;
+typedef void (*bfa_ioc_sm_t)(struct bfa_ioc_s *fsm, enum ioc_event);
+
 enum bfa_ioc_event_e {
 	BFA_IOC_E_ENABLED	= 1,
 	BFA_IOC_E_DISABLED	= 2,
@@ -282,8 +300,29 @@ struct bfa_ioc_notify_s {
 	(__notify)->cbarg = (__cbarg);      \
 } while (0)
 
+/*
+ * IOCPF state machine events
+ */
+enum iocpf_event {
+	IOCPF_E_ENABLE		= 1,	/*  IOCPF enable request	*/
+	IOCPF_E_DISABLE		= 2,	/*  IOCPF disable request	*/
+	IOCPF_E_STOP		= 3,	/*  stop on driver detach	*/
+	IOCPF_E_FWREADY		= 4,	/*  f/w initialization done	*/
+	IOCPF_E_FWRSP_ENABLE	= 5,	/*  enable f/w response	*/
+	IOCPF_E_FWRSP_DISABLE	= 6,	/*  disable f/w response	*/
+	IOCPF_E_FAIL		= 7,	/*  failure notice by ioc sm	*/
+	IOCPF_E_INITFAIL	= 8,	/*  init fail notice by ioc sm	*/
+	IOCPF_E_GETATTRFAIL	= 9,	/*  init fail notice by ioc sm	*/
+	IOCPF_E_SEMLOCKED	= 10,	/*  h/w semaphore is locked	*/
+	IOCPF_E_TIMEOUT		= 11,	/*  f/w response timeout	*/
+	IOCPF_E_SEM_ERROR	= 12,	/*  h/w sem mapping error	*/
+};
+
+struct bfa_iocpf_s;
+typedef void (*bfa_iocpf_sm_t)(struct bfa_iocpf_s *fsm, enum iocpf_event);
+
 struct bfa_iocpf_s {
-	bfa_fsm_t		fsm;
+	bfa_iocpf_sm_t		fsm;
 	struct bfa_ioc_s	*ioc;
 	bfa_boolean_t		fw_mismatch_notified;
 	bfa_boolean_t		auto_recover;
@@ -291,7 +330,7 @@ struct bfa_iocpf_s {
 };
 
 struct bfa_ioc_s {
-	bfa_fsm_t		fsm;
+	bfa_ioc_sm_t		fsm;
 	struct bfa_s		*bfa;
 	struct bfa_pcidev_s	pcidev;
 	struct bfa_timer_mod_s	*timer_mod;
@@ -379,22 +418,6 @@ struct bfa_cb_qe_s {
 	void		*cbarg;
 };
 
-/*
- * IOCFC state machine definitions/declarations
- */
-enum iocfc_event {
-	IOCFC_E_INIT		= 1,	/* IOCFC init request		*/
-	IOCFC_E_START		= 2,	/* IOCFC mod start request	*/
-	IOCFC_E_STOP		= 3,	/* IOCFC stop request		*/
-	IOCFC_E_ENABLE		= 4,	/* IOCFC enable request		*/
-	IOCFC_E_DISABLE		= 5,	/* IOCFC disable request	*/
-	IOCFC_E_IOC_ENABLED	= 6,	/* IOC enabled message		*/
-	IOCFC_E_IOC_DISABLED	= 7,	/* IOC disabled message		*/
-	IOCFC_E_IOC_FAILED	= 8,	/* failure notice by IOC sm	*/
-	IOCFC_E_DCONF_DONE	= 9,	/* dconf read/write done	*/
-	IOCFC_E_CFG_DONE	= 10,	/* IOCFC config complete	*/
-};
-
 /*
  * ASIC block configurtion related
  */
@@ -779,8 +802,23 @@ struct bfa_dconf_s {
 };
 #pragma pack()
 
+/*
+ * DCONF state machine events
+ */
+enum bfa_dconf_event {
+	BFA_DCONF_SM_INIT		= 1,	/* dconf Init */
+	BFA_DCONF_SM_FLASH_COMP		= 2,	/* read/write to flash */
+	BFA_DCONF_SM_WR			= 3,	/* binding change, map */
+	BFA_DCONF_SM_TIMEOUT		= 4,	/* Start timer */
+	BFA_DCONF_SM_EXIT		= 5,	/* exit dconf module */
+	BFA_DCONF_SM_IOCDISABLE		= 6,	/* IOC disable event */
+};
+
+struct bfa_dconf_mod_s;
+typedef void (*bfa_dconf_sm_t)(struct bfa_dconf_mod_s *fsm, enum bfa_dconf_event);
+
 struct bfa_dconf_mod_s {
-	bfa_sm_t		sm;
+	bfa_dconf_sm_t		sm;
 	u8			instance;
 	bfa_boolean_t		read_data_valid;
 	bfa_boolean_t		min_cfg;
diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
index c9745c0b4eee3..9f33aa303b189 100644
--- a/drivers/scsi/bfa/bfa_svc.c
+++ b/drivers/scsi/bfa/bfa_svc.c
@@ -40,36 +40,6 @@ BFA_TRC_FILE(HAL, FCXP);
 	((bfa_fcport_is_disabled(bfa) == BFA_TRUE) || \
 	(bfa_ioc_is_disabled(&bfa->ioc) == BFA_TRUE))
 
-/*
- * BFA port state machine events
- */
-enum bfa_fcport_sm_event {
-	BFA_FCPORT_SM_START	= 1,	/*  start port state machine	*/
-	BFA_FCPORT_SM_STOP	= 2,	/*  stop port state machine	*/
-	BFA_FCPORT_SM_ENABLE	= 3,	/*  enable port		*/
-	BFA_FCPORT_SM_DISABLE	= 4,	/*  disable port state machine */
-	BFA_FCPORT_SM_FWRSP	= 5,	/*  firmware enable/disable rsp */
-	BFA_FCPORT_SM_LINKUP	= 6,	/*  firmware linkup event	*/
-	BFA_FCPORT_SM_LINKDOWN	= 7,	/*  firmware linkup down	*/
-	BFA_FCPORT_SM_QRESUME	= 8,	/*  CQ space available	*/
-	BFA_FCPORT_SM_HWFAIL	= 9,	/*  IOC h/w failure		*/
-	BFA_FCPORT_SM_DPORTENABLE = 10, /*  enable dport      */
-	BFA_FCPORT_SM_DPORTDISABLE = 11,/*  disable dport     */
-	BFA_FCPORT_SM_FAA_MISCONFIG = 12,	/* FAA misconfiguratin */
-	BFA_FCPORT_SM_DDPORTENABLE  = 13,	/* enable ddport	*/
-	BFA_FCPORT_SM_DDPORTDISABLE = 14,	/* disable ddport	*/
-};
-
-/*
- * BFA port link notification state machine events
- */
-
-enum bfa_fcport_ln_sm_event {
-	BFA_FCPORT_LN_SM_LINKUP		= 1,	/*  linkup event	*/
-	BFA_FCPORT_LN_SM_LINKDOWN	= 2,	/*  linkdown event	*/
-	BFA_FCPORT_LN_SM_NOTIFICATION	= 3	/*  done notification	*/
-};
-
 /*
  * RPORT related definitions
  */
@@ -201,7 +171,23 @@ static void     bfa_fcport_ln_sm_up_dn_nf(struct bfa_fcport_ln_s *ln,
 static void     bfa_fcport_ln_sm_up_dn_up_nf(struct bfa_fcport_ln_s *ln,
 					enum bfa_fcport_ln_sm_event event);
 
-static struct bfa_sm_table_s hal_port_sm_table[] = {
+struct bfa_fcport_sm_table_s {
+	bfa_fcport_sm_t sm;		/*  state machine function	*/
+	enum bfa_port_states state;	/*  state machine encoding	*/
+	char		*name;		/*  state name for display	*/
+};
+
+static inline enum bfa_port_states
+bfa_fcport_sm_to_state(struct bfa_fcport_sm_table_s *smt, bfa_fcport_sm_t sm)
+{
+	int i = 0;
+
+	while (smt[i].sm && smt[i].sm != sm)
+		i++;
+	return smt[i].state;
+}
+
+static struct bfa_fcport_sm_table_s hal_port_sm_table[] = {
 	{BFA_SM(bfa_fcport_sm_uninit), BFA_PORT_ST_UNINIT},
 	{BFA_SM(bfa_fcport_sm_enabling_qwait), BFA_PORT_ST_ENABLING_QWAIT},
 	{BFA_SM(bfa_fcport_sm_enabling), BFA_PORT_ST_ENABLING},
@@ -3545,7 +3531,7 @@ bfa_fcport_isr(struct bfa_s *bfa, struct bfi_msg_s *msg)
 	fcport->event_arg.i2hmsg = i2hmsg;
 
 	bfa_trc(bfa, msg->mhdr.msg_id);
-	bfa_trc(bfa, bfa_sm_to_state(hal_port_sm_table, fcport->sm));
+	bfa_trc(bfa, bfa_fcport_sm_to_state(hal_port_sm_table, fcport->sm));
 
 	switch (msg->mhdr.msg_id) {
 	case BFI_FCPORT_I2H_ENABLE_RSP:
@@ -3980,7 +3966,7 @@ bfa_fcport_get_attr(struct bfa_s *bfa, struct bfa_port_attr_s *attr)
 
 	attr->pport_cfg.path_tov  = bfa_fcpim_path_tov_get(bfa);
 	attr->pport_cfg.q_depth  = bfa_fcpim_qdepth_get(bfa);
-	attr->port_state = bfa_sm_to_state(hal_port_sm_table, fcport->sm);
+	attr->port_state = bfa_fcport_sm_to_state(hal_port_sm_table, fcport->sm);
 
 	attr->fec_state = fcport->fec_state;
 
@@ -4062,7 +4048,7 @@ bfa_fcport_is_disabled(struct bfa_s *bfa)
 {
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(bfa);
 
-	return bfa_sm_to_state(hal_port_sm_table, fcport->sm) ==
+	return bfa_fcport_sm_to_state(hal_port_sm_table, fcport->sm) ==
 		BFA_PORT_ST_DISABLED;
 
 }
@@ -4072,7 +4058,7 @@ bfa_fcport_is_dport(struct bfa_s *bfa)
 {
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(bfa);
 
-	return (bfa_sm_to_state(hal_port_sm_table, fcport->sm) ==
+	return (bfa_fcport_sm_to_state(hal_port_sm_table, fcport->sm) ==
 		BFA_PORT_ST_DPORT);
 }
 
@@ -4081,7 +4067,7 @@ bfa_fcport_is_ddport(struct bfa_s *bfa)
 {
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(bfa);
 
-	return (bfa_sm_to_state(hal_port_sm_table, fcport->sm) ==
+	return (bfa_fcport_sm_to_state(hal_port_sm_table, fcport->sm) ==
 		BFA_PORT_ST_DDPORT);
 }
 
@@ -5641,20 +5627,6 @@ enum bfa_dport_test_state_e {
 	BFA_DPORT_ST_NOTSTART	= 4,	/*!< test not start dport is enabled */
 };
 
-/*
- * BFA DPORT state machine events
- */
-enum bfa_dport_sm_event {
-	BFA_DPORT_SM_ENABLE	= 1,	/* dport enable event         */
-	BFA_DPORT_SM_DISABLE    = 2,    /* dport disable event        */
-	BFA_DPORT_SM_FWRSP      = 3,    /* fw enable/disable rsp      */
-	BFA_DPORT_SM_QRESUME    = 4,    /* CQ space available         */
-	BFA_DPORT_SM_HWFAIL     = 5,    /* IOC h/w failure            */
-	BFA_DPORT_SM_START	= 6,	/* re-start dport test        */
-	BFA_DPORT_SM_REQFAIL	= 7,	/* request failure            */
-	BFA_DPORT_SM_SCN	= 8,	/* state change notify frm fw */
-};
-
 static void bfa_dport_sm_disabled(struct bfa_dport_s *dport,
 				  enum bfa_dport_sm_event event);
 static void bfa_dport_sm_enabling_qwait(struct bfa_dport_s *dport,
diff --git a/drivers/scsi/bfa/bfa_svc.h b/drivers/scsi/bfa/bfa_svc.h
index 9c83109574e91..26eeee82bedc6 100644
--- a/drivers/scsi/bfa/bfa_svc.h
+++ b/drivers/scsi/bfa/bfa_svc.h
@@ -226,22 +226,6 @@ struct bfa_fcxp_wqe_s {
 
 void	bfa_fcxp_isr(struct bfa_s *bfa, struct bfi_msg_s *msg);
 
-
-/*
- * RPORT related defines
- */
-enum bfa_rport_event {
-	BFA_RPORT_SM_CREATE	= 1,	/*  rport create event          */
-	BFA_RPORT_SM_DELETE	= 2,	/*  deleting an existing rport  */
-	BFA_RPORT_SM_ONLINE	= 3,	/*  rport is online             */
-	BFA_RPORT_SM_OFFLINE	= 4,	/*  rport is offline            */
-	BFA_RPORT_SM_FWRSP	= 5,	/*  firmware response           */
-	BFA_RPORT_SM_HWFAIL	= 6,	/*  IOC h/w failure             */
-	BFA_RPORT_SM_QOS_SCN	= 7,	/*  QoS SCN from firmware       */
-	BFA_RPORT_SM_SET_SPEED	= 8,	/*  Set Rport Speed             */
-	BFA_RPORT_SM_QRESUME	= 9,	/*  space in requeue queue      */
-};
-
 #define BFA_RPORT_MIN	4
 
 struct bfa_rport_mod_s {
@@ -284,12 +268,30 @@ struct bfa_rport_info_s {
 	enum bfa_port_speed speed;	/*  Rport's current speed	    */
 };
 
+/*
+ * RPORT related defines
+ */
+enum bfa_rport_event {
+	BFA_RPORT_SM_CREATE	= 1,	/*  rport create event          */
+	BFA_RPORT_SM_DELETE	= 2,	/*  deleting an existing rport  */
+	BFA_RPORT_SM_ONLINE	= 3,	/*  rport is online             */
+	BFA_RPORT_SM_OFFLINE	= 4,	/*  rport is offline            */
+	BFA_RPORT_SM_FWRSP	= 5,	/*  firmware response           */
+	BFA_RPORT_SM_HWFAIL	= 6,	/*  IOC h/w failure             */
+	BFA_RPORT_SM_QOS_SCN	= 7,	/*  QoS SCN from firmware       */
+	BFA_RPORT_SM_SET_SPEED	= 8,	/*  Set Rport Speed             */
+	BFA_RPORT_SM_QRESUME	= 9,	/*  space in requeue queue      */
+};
+
+struct bfa_rport_s;
+typedef void (*bfa_rport_sm_t)(struct bfa_rport_s *, enum bfa_rport_event);
+
 /*
  * BFA rport data structure
  */
 struct bfa_rport_s {
 	struct list_head	qe;	/*  queue element		    */
-	bfa_sm_t	sm;		/*  state machine		    */
+	bfa_rport_sm_t	sm;		/*  state machine		    */
 	struct bfa_s	*bfa;		/*  backpointer to BFA		    */
 	void		*rport_drv;	/*  fcs/driver rport object	    */
 	u16	fw_handle;	/*  firmware rport handle	    */
@@ -377,13 +379,31 @@ struct bfa_uf_mod_s {
 void	bfa_uf_isr(struct bfa_s *bfa, struct bfi_msg_s *msg);
 void	bfa_uf_res_recfg(struct bfa_s *bfa, u16 num_uf_fw);
 
+/*
+ *  lps_pvt BFA LPS private functions
+ */
+
+enum bfa_lps_event {
+	BFA_LPS_SM_LOGIN	= 1,	/* login request from user      */
+	BFA_LPS_SM_LOGOUT	= 2,	/* logout request from user     */
+	BFA_LPS_SM_FWRSP	= 3,	/* f/w response to login/logout */
+	BFA_LPS_SM_RESUME	= 4,	/* space present in reqq queue  */
+	BFA_LPS_SM_DELETE	= 5,	/* lps delete from user         */
+	BFA_LPS_SM_OFFLINE	= 6,	/* Link is offline              */
+	BFA_LPS_SM_RX_CVL	= 7,	/* Rx clear virtual link        */
+	BFA_LPS_SM_SET_N2N_PID  = 8,	/* Set assigned PID for n2n */
+};
+
+struct bfa_lps_s;
+typedef void (*bfa_lps_sm_t)(struct bfa_lps_s *, enum bfa_lps_event);
+
 /*
  * LPS - bfa lport login/logout service interface
  */
 struct bfa_lps_s {
 	struct list_head	qe;	/*  queue element		*/
 	struct bfa_s	*bfa;		/*  parent bfa instance	*/
-	bfa_sm_t	sm;		/*  finite state machine	*/
+	bfa_lps_sm_t	sm;		/*  finite state machine	*/
 	u8		bfa_tag;	/*  lport tag		*/
 	u8		fw_tag;		/*  lport fw tag                */
 	u8		reqq;		/*  lport request queue	*/
@@ -439,12 +459,25 @@ void	bfa_lps_isr(struct bfa_s *bfa, struct bfi_msg_s *msg);
 
 #define BFA_FCPORT(_bfa)	(&((_bfa)->modules.port))
 
+/*
+ * BFA port link notification state machine events
+ */
+
+enum bfa_fcport_ln_sm_event {
+	BFA_FCPORT_LN_SM_LINKUP		= 1,	/*  linkup event	*/
+	BFA_FCPORT_LN_SM_LINKDOWN	= 2,	/*  linkdown event	*/
+	BFA_FCPORT_LN_SM_NOTIFICATION	= 3	/*  done notification	*/
+};
+
+struct bfa_fcport_ln_s;
+typedef void (*bfa_fcport_ln_sm_t)(struct bfa_fcport_ln_s *, enum bfa_fcport_ln_sm_event);
+
 /*
  * Link notification data structure
  */
 struct bfa_fcport_ln_s {
 	struct bfa_fcport_s	*fcport;
-	bfa_sm_t		sm;
+	bfa_fcport_ln_sm_t	sm;
 	struct bfa_cb_qe_s	ln_qe;	/*  BFA callback queue elem for ln */
 	enum bfa_port_linkstate ln_event; /*  ln event for callback */
 };
@@ -453,12 +486,35 @@ struct bfa_fcport_trunk_s {
 	struct bfa_trunk_attr_s	attr;
 };
 
+/*
+ * BFA port state machine events
+ */
+enum bfa_fcport_sm_event {
+	BFA_FCPORT_SM_START	= 1,	/*  start port state machine	*/
+	BFA_FCPORT_SM_STOP	= 2,	/*  stop port state machine	*/
+	BFA_FCPORT_SM_ENABLE	= 3,	/*  enable port		*/
+	BFA_FCPORT_SM_DISABLE	= 4,	/*  disable port state machine */
+	BFA_FCPORT_SM_FWRSP	= 5,	/*  firmware enable/disable rsp */
+	BFA_FCPORT_SM_LINKUP	= 6,	/*  firmware linkup event	*/
+	BFA_FCPORT_SM_LINKDOWN	= 7,	/*  firmware linkup down	*/
+	BFA_FCPORT_SM_QRESUME	= 8,	/*  CQ space available	*/
+	BFA_FCPORT_SM_HWFAIL	= 9,	/*  IOC h/w failure		*/
+	BFA_FCPORT_SM_DPORTENABLE = 10, /*  enable dport      */
+	BFA_FCPORT_SM_DPORTDISABLE = 11,/*  disable dport     */
+	BFA_FCPORT_SM_FAA_MISCONFIG = 12,	/* FAA misconfiguratin */
+	BFA_FCPORT_SM_DDPORTENABLE  = 13,	/* enable ddport	*/
+	BFA_FCPORT_SM_DDPORTDISABLE = 14,	/* disable ddport	*/
+};
+
+struct bfa_fcport_s;
+typedef void (*bfa_fcport_sm_t)(struct bfa_fcport_s *, enum bfa_fcport_sm_event);
+
 /*
  * BFA FC port data structure
  */
 struct bfa_fcport_s {
 	struct bfa_s		*bfa;	/*  parent BFA instance */
-	bfa_sm_t		sm;	/*  port state machine */
+	bfa_fcport_sm_t		sm;	/*  port state machine */
 	wwn_t			nwwn;	/*  node wwn of physical port */
 	wwn_t			pwwn;	/*  port wwn of physical oprt */
 	enum bfa_port_speed speed_sup;
@@ -706,9 +762,26 @@ struct bfa_fcdiag_lb_s {
 	u32        status;
 };
 
+/*
+ * BFA DPORT state machine events
+ */
+enum bfa_dport_sm_event {
+	BFA_DPORT_SM_ENABLE	= 1,	/* dport enable event         */
+	BFA_DPORT_SM_DISABLE    = 2,    /* dport disable event        */
+	BFA_DPORT_SM_FWRSP      = 3,    /* fw enable/disable rsp      */
+	BFA_DPORT_SM_QRESUME    = 4,    /* CQ space available         */
+	BFA_DPORT_SM_HWFAIL     = 5,    /* IOC h/w failure            */
+	BFA_DPORT_SM_START	= 6,	/* re-start dport test        */
+	BFA_DPORT_SM_REQFAIL	= 7,	/* request failure            */
+	BFA_DPORT_SM_SCN	= 8,	/* state change notify frm fw */
+};
+
+struct bfa_dport_s;
+typedef void (*bfa_dport_sm_t)(struct bfa_dport_s *, enum bfa_dport_sm_event);
+
 struct bfa_dport_s {
 	struct bfa_s	*bfa;		/* Back pointer to BFA	*/
-	bfa_sm_t	sm;		/* finite state machine */
+	bfa_dport_sm_t	sm;		/* finite state machine */
 	struct bfa_reqq_wait_s reqq_wait;
 	bfa_cb_diag_t	cbfn;
 	void		*cbarg;
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 62cb7a864fd53..ebf7c80ec6b20 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -142,19 +142,19 @@ module_param(max_rport_logins, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(max_rport_logins, "Max number of logins to initiator and target rports on a port (physical/logical), default=1024");
 
 static void
-bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event);
 static void
-bfad_sm_created(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_created(struct bfad_s *bfad, enum bfad_sm_event);
 static void
-bfad_sm_initializing(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_initializing(struct bfad_s *bfad, enum bfad_sm_event);
 static void
-bfad_sm_operational(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_operational(struct bfad_s *bfad, enum bfad_sm_event);
 static void
-bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event);
 static void
-bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event);
 static void
-bfad_sm_fcs_exit(struct bfad_s *bfad, enum bfad_sm_event event);
+bfad_sm_fcs_exit(struct bfad_s *bfad, enum bfad_sm_event);
 
 /*
  * Beginning state for the driver instance, awaiting the pci_probe event
diff --git a/drivers/scsi/bfa/bfad_drv.h b/drivers/scsi/bfa/bfad_drv.h
index 7682cfa34265d..da42e3261237e 100644
--- a/drivers/scsi/bfa/bfad_drv.h
+++ b/drivers/scsi/bfa/bfad_drv.h
@@ -175,11 +175,27 @@ union bfad_tmp_buf {
 	wwn_t		wwn[BFA_FCS_MAX_LPORTS];
 };
 
+/* BFAD state machine events */
+enum bfad_sm_event {
+	BFAD_E_CREATE			= 1,
+	BFAD_E_KTHREAD_CREATE_FAILED	= 2,
+	BFAD_E_INIT			= 3,
+	BFAD_E_INIT_SUCCESS		= 4,
+	BFAD_E_HAL_INIT_FAILED		= 5,
+	BFAD_E_INIT_FAILED		= 6,
+	BFAD_E_FCS_EXIT_COMP		= 7,
+	BFAD_E_EXIT_COMP		= 8,
+	BFAD_E_STOP			= 9
+};
+
+struct bfad_s;
+typedef void (*bfad_sm_t)(struct bfad_s *, enum bfad_sm_event);
+
 /*
  * BFAD (PCI function) data structure
  */
 struct bfad_s {
-	bfa_sm_t	sm;	/* state machine */
+	bfad_sm_t	sm;	/* state machine */
 	struct list_head list_entry;
 	struct bfa_s	bfa;
 	struct bfa_fcs_s bfa_fcs;
@@ -226,19 +242,6 @@ struct bfad_s {
 	struct list_head	vport_list;
 };
 
-/* BFAD state machine events */
-enum bfad_sm_event {
-	BFAD_E_CREATE			= 1,
-	BFAD_E_KTHREAD_CREATE_FAILED	= 2,
-	BFAD_E_INIT			= 3,
-	BFAD_E_INIT_SUCCESS		= 4,
-	BFAD_E_HAL_INIT_FAILED		= 5,
-	BFAD_E_INIT_FAILED		= 6,
-	BFAD_E_FCS_EXIT_COMP		= 7,
-	BFAD_E_EXIT_COMP		= 8,
-	BFAD_E_STOP			= 9
-};
-
 /*
  * RPORT data structure
  */
-- 
2.39.2

