Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CDE2271EA
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 23:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGTVwr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 17:52:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43688 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgGTVwr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Jul 2020 17:52:47 -0400
IronPort-SDR: x06T1dFl5lF4+G3CsXr7vNRAiyOfPjUqqxXWpXoTR22CTf19f8VOocZzVp2QzQWWlZOMs/Bmil
 eTG3DfK7gLs4xuTpKD2D8v8RTLofypBIv7/FqZSpfiC8L3n3n2ljwi7x4Bao/MIUs7WAe6SBpl
 JF/UpLVjzFkKBR7vLlvwVfaZirYBVo+tAWhHJ5kUQS7QsjN2tLreZlo7xAPgHIHTAAKnScFEj2
 pUuh1dn/DBcP2HljV7PJCUVkncVEBa49Sh+YyDr30c2Sv3YU5Sb8N6PC1le3kRocAUNNrRU6cS
 hGs=
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="84670892"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2020 14:52:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 14:52:07 -0700
Received: from [127.0.1.1] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 20 Jul 2020 14:52:09 -0700
Subject: [PATCH 0/4] hpsa updates
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Mon, 20 Jul 2020 16:52:46 -0500
Message-ID: <159528193513.24772.2142294136346611232.stgit@brunhilda>
User-Agent: StGit/0.23-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

These patches are based on Linus's tree

The changes are:
hpsa-correct-rare-oob-condition
 - Rare condition where a spare is first in
   PHYS LUN list.
hpsa-increase-qd-for-external-luns
 - Improve performance for PTRAID devices
   - Such as MSA devices.
hpsa-increase-ctlr-eh-timeout
 - Increase timeout for commands issued to
   controller device.
 - Improve multipath failover handling.
hpsa-bump-version

---

Don Brace (4):
      hpsa: correct rare oob condition
      hpsa: increase qd for external luns
      hpsa: increase ctlr eh timeout
      hpsa: bump version


 drivers/scsi/hpsa.c | 6 +++++-
 drivers/scsi/hpsa.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

--
Signature
