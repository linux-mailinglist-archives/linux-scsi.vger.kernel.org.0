Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA49F153A65
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Feb 2020 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBEVnY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Feb 2020 16:43:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:52402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgBEVnY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Feb 2020 16:43:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7937AB3D;
        Wed,  5 Feb 2020 21:43:22 +0000 (UTC)
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 0/3] scsi: qla2xxx: fixes for driver unloading
Date:   Wed,  5 Feb 2020 22:44:19 +0100
Message-Id: <20200205214422.3657-1-mwilck@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

Hello Martin, Himanshu, all,

here is v2 of the little series I first submitted on Nov 29, 2019.

Changes wrt v2:
 - Added patch 3 to set the UNLOADING flag before waiting for sessions
   to end (Roman)
 - Use test_and_set_bit() for UNLOADING (Hannes)

Martin Wilck (3):
  scsi: qla2xxx: avoid sending mailbox commands if firmware is stopped
  scsi: qla2xxx: don't shut down firmware before closing sessions
  scsi: qla2xxx: set UNLOADING before waiting for session deletion

 drivers/scsi/qla2xxx/qla_mbx.c |  3 +++
 drivers/scsi/qla2xxx/qla_os.c  | 39 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.25.0

