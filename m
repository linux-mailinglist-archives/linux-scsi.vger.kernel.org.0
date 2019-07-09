Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6D633D3
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGIKAb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 06:00:31 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:32128 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIKAa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 06:00:30 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa6.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: kpiODLTbSVDZde3PuAdwpxn1pFnfLs75MHs+uSGETeYxXvGI0M1ZyrH/bvENJGXdsa/urKQ4ME
 nIfyhGRVnklRpf9ovS2MMx81QITrFlRJNcE4Uoy65o3BvIkW+tAGi/xHyaAoecWLi85oP0OXBA
 KFoZlwdCKFKonD9OS9swPHhkGPDl919kI5VEL8Olm28x90zWmapG7GXKxvlby9CwBNLT9Fy4Jm
 0H5D7n+CxAFN/FfeJeASzaj2tZEzWufNZNPf6N+sb9YWxTlW0JkmXXCPQtu4ELwuAgPh3UYKf8
 kuE=
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="37443553"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2019 03:00:30 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jul 2019
 03:00:29 -0700
Received: from localhost (10.41.130.49) by avmbx3.microsemi.net (10.100.34.33)
 with Microsoft SMTP Server id 15.1.1713.5 via Frontend Transport; Tue, 9 Jul
 2019 03:00:28 -0700
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@cloud.ionos.com>, <martin.petersen@oracle.com>
Subject: [PATCH V2 0/3] pm0xx : Updates for driver version 0.1.39.
Date:   Tue, 9 Jul 2019 15:30:47 +0530
Message-ID: <20190709100050.6947-1-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch set include some bug fixes for pm80xx driver.

Changes from V1:
	For "Fixed kernel panic during error recovery for SATA drive" patch,
		-Acquired the spin lock after aborting all the requests. 

Deepak Ukey (3):
  pm80xx : Fixed kernel panic during error recovery for SATA drive.
  pm80xx : Event log size through sysfs.
  pm80xx : Modified the logic to collect IOP event logs.

 drivers/scsi/pm8001/pm8001_ctl.c | 52 +++++++++++++++++++++++++++-------------
 drivers/scsi/pm8001/pm8001_sas.c |  6 ++++-
 drivers/scsi/pm8001/pm80xx_hwi.c |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.h |  2 ++
 4 files changed, 44 insertions(+), 18 deletions(-)

-- 
1.8.5.6

