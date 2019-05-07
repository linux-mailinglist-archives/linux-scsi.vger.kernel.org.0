Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4866016A30
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEGSb5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:31:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24095 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfEGSb5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:31:57 -0400
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.99.222 as permitted
  sender) identity=mailfrom; client-ip=208.19.99.222;
  receiver=esa5.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa5.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.60,443,1549954800"; 
   d="scan'208";a="30471168"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:31:57 -0700
Received: from AUSMBX2.microsemi.net (10.201.34.32) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 13:31:54 -0500
Received: from [127.0.1.1] (10.238.32.34) by ausmbx2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 13:31:54 -0500
Subject: [PATCH 0/7] hpsa updates
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:31:54 -0500
Message-ID: <155725372104.27200.12250663760304977059.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

These patches are based on Linus's tree

The changes are:
hpsa-correct-simple-mode
 - correct interrupt setup for simple-mode
hpsa-use-local-workqueues-instead-of-system-workqueues
 - use driver workqueue to avoid stalling OS.
hpsa-check-for-tag-collision
 - correct rare multipath issue.
hpsa-wait-longer-for-ptraid-commands
 - correct rare multipath issue.
hpsa-do-not-complete-cmds-for-deleted-devices
 - correct rare multipath issue.
hpsa-correct-device-resets
 - fix race condition in reset handler
hpsa-update-driver-version
 - update to track changes

---

Don Brace (7):
      hpsa: correct simple mode
      hpsa: use local workqueues instead of system workqueues
      hpsa: check for tag collision
      hpsa: wait longer for ptraid commands
      hpsa: do-not-complete-cmds-for-deleted-devices
      hpsa: correct device resets
      hpsa: update driver version


 drivers/scsi/hpsa.c     |  278 ++++++++++++++++++++++++++++-------------------
 drivers/scsi/hpsa.h     |    6 +
 drivers/scsi/hpsa_cmd.h |    2 
 3 files changed, 174 insertions(+), 112 deletions(-)

--
Signature
