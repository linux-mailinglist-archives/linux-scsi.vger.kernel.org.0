Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE927413B
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jul 2019 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGXWIU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 18:08:20 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:64440 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfGXWIU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Jul 2019 18:08:20 -0400
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.99.222 as permitted
  sender) identity=mailfrom; client-ip=208.19.99.222;
  receiver=esa1.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa1.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
IronPort-SDR: C/FqTdEX+JX8fYQgTYp0f4XBZwLCVmtuQWPAU91M/fNt1DwPTXs1FmmYrgjSiVCrS4jyrUNDOk
 VPSHpk3IekdrORd87M+MZpGjFiHrGk2C/VaVAd/yO1eB4KkeT5hdg/80LBeIpjO5tIhB3H5eqX
 yjoviqa/p2J/diWPb5DL7wbzoqWNITPHhO206krdb3KuvBcFftwrgEgMrXYMAB18Qlnk5ZO9Jm
 nQTq9jX36J+1HLd/cTUMEETTo2+o+Bi7Zq0CcWWLEiihAC3bLKd9ZOrrLyfzciNIhlmInwdac1
 BsY=
X-IronPort-AV: E=Sophos;i="5.64,304,1559545200"; 
   d="scan'208";a="44028955"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2019 15:08:14 -0700
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 24 Jul
 2019 17:08:13 -0500
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 24 Jul
 2019 17:08:12 -0500
Received: from [127.0.1.1] (10.238.32.34) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 24 Jul 2019 17:08:12 -0500
Subject: [PATCH 2/2] hpsa: remove printing internal cdb on tag collision
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Wed, 24 Jul 2019 17:08:12 -0500
Message-ID: <156400609225.14150.8886880500086250302.stgit@brunhilda>
In-Reply-To: <156400599822.14150.10317539253759491318.stgit@brunhilda>
References: <156400599822.14150.10317539253759491318.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- remove racy printing of internal commands.
  . completion thread can be cleaning up the command in parallel

Reviewed-by: Bader Ali - Saleh <bader.alisaleh@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 89e71ebc5964..bba099e53266 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6091,8 +6091,6 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 		if (idx != h->last_collision_tag) { /* Print once per tag */
 			dev_warn(&h->pdev->dev,
 				"%s: tag collision (tag=%d)\n", __func__, idx);
-			if (c->scsi_cmd != NULL)
-				scsi_print_command(c->scsi_cmd);
 			if (scmd)
 				scsi_print_command(scmd);
 			h->last_collision_tag = idx;

