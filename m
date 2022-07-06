Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F55695EE
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jul 2022 01:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiGFXeb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 19:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiGFXea (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 19:34:30 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7E72C661;
        Wed,  6 Jul 2022 16:34:27 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 34CCF4077F;
        Wed,  6 Jul 2022 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150467; bh=vR3gXJ31+j6pKaj/PWa3xpLpSdecusUouURxFMx5HgE=;
        h=Date:From:Subject:To:Cc:From;
        b=Dax/3zvidSsR0w8GT5pTviAtgfYo8T/xJzhzuorB2tucyqVhG5K3PNZlTuNk5xf/Z
         9WjKhZod084/1ezxjGginCrn0gslEJiWW401jnevOoKKG1WAvLWhKdgeUidttk2JV6
         SE3VJS3BFhHUI9n6ei53bCyFKUh0RXa5yI++4/KgESSkxVradL8dY6xLMJhS7Hb3eS
         EDffRpxmWT+MruSSWSVxqmM9unqhpLd2tk/Fgd/R+prudiomIJadChbXu9I6bLxSZf
         V3Som0SrPvruACPQoNpsWiTSXz8uR6fyAMkvRhRYM2gASAYZCPpllcpOus3F5qrKhp
         gEz/GY7/wIsoQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 51BD4A0063;
        Wed,  6 Jul 2022 23:34:20 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:34:20 -0700
Date:   Wed, 06 Jul 2022 16:34:20 -0700
Message-Id: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 00/36] usb: gadget: f_tcm: Enhance UASP driver
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The Linux UASP gadget driver is incomplete and remained broken for a long time.
It was not implemented for performance either. This series adds some of the
required features for the UASP driver to work. It also makes some fixes to the
target core.

Please note that the f_tcm is far from a good state. It needs better error
recovery, error reports, more cleanup, and the ability to handle various
required commands.

Also please note that I try to juggle between checkpatch warnings and code
style consistency. As a result, there maybe some minor checkpatch warnings.

Hopefully this can help jumpstart the UASP driver. Please test it out.

This was tested against UASP CV and DWC_usb3x controller.

Thanks!


Thinh Nguyen (36):
  target: Handle MI_REPORT_SUPPORTED_OPERATION_CODES
  target: Add overlapped response to tmrsp_table
  target: Don't drain empty list
  target: Does tmr notify on aborted command
  target: Don't remove command too early
  target: Return Function Complete
  target: Don't do tmr_notify on empty aborted list
  target: Refactor core_tmr_abort_task
  target: Add common Task Management values
  target: Implement TMR_ABORT_TASK_SET
  target: Properly set Sense Data Length of CHECK CONDITION
  target: Properly set Sense data length when copy sense
  target: Don't respond TMR_LUN_DOES_NOT_EXIST for all TMR failure
  target: Introduce target_submit_tmr_fail_response
  target: Include INQUIRY length
  usb: gadget: f_tcm: Increase stream count
  usb: gadget: f_tcm: Increase bMaxBurst
  usb: gadget: f_tcm: Don't set static stream_id
  usb: gadget: f_tcm: Allocate matching number of commands to streams
  usb: gadget: f_tcm: Limit number of sessions
  usb: gadget: f_tcm: Handle multiple commands in parallel
  usb: gadget: f_tcm: Use extra number of commands
  usb: gadget: f_tcm: Return ATA cmd direction
  usb: gadget: f_tcm: Execute command on write completion
  usb: gadget: f_tcm: Minor cleanup redundant code
  usb: gadget: f_tcm: Don't free command immediately
  usb: gadget: f_tcm: Translate error to sense
  usb: gadget: f_tcm: Cleanup unused variable
  usb: gadget: f_tcm: Update state on data write
  usb: gadget: f_tcm: Handle abort command
  usb: gadget: f_tcm: Cleanup requests on ep disable
  usb: gadget: f_tcm: Send sense reason
  usb: gadget: f_tcm: Save CPU ID per command
  usb: gadget: f_tcm: Free tags earlier
  usb: gadget: f_tcm: Handle TASK_MANAGEMENT commands
  usb: gadget: f_tcm: Comply with UAS Task Management requirement

 drivers/target/target_core_alua.c      |  66 ++++
 drivers/target/target_core_alua.h      |   2 +
 drivers/target/target_core_spc.c       |  16 +-
 drivers/target/target_core_tmr.c       |  39 +-
 drivers/target/target_core_transport.c |  73 +++-
 drivers/usb/gadget/function/f_tcm.c    | 502 ++++++++++++++++++-------
 drivers/usb/gadget/function/tcm.h      |  20 +-
 include/target/target_core_base.h      |   9 +-
 include/target/target_core_fabric.h    |   3 +
 9 files changed, 562 insertions(+), 168 deletions(-)


base-commit: 90557fa89d3e99286506593fd5180f699c41b152
-- 
2.28.0

