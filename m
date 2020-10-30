Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5793929FD86
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Oct 2020 06:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ3F7R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Oct 2020 01:59:17 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:57054 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3F7R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Oct 2020 01:59:17 -0400
IronPort-SDR: 0no7T5cjGbvJaxWlQy7vTsHrr9I07dcZALmb2HXA4TbfskLK1DNSWBRpI2ciBLfbwSbPIRLsIM
 XXwjdk2QDj9d2ikuvp1b5sbJFSQsHbfWMVRsGzQySSdoforGK9s8P2PdJySMv6BgTgZccEs5sg
 sYX36gQeOTWCk85FsCPZFCKhElJmD1IOYL4KYEmMQHLhrsLrmooFcTESBuBnYkqf5q5AcXzYP0
 mK+wT8fkSV5hdsbMMxw5FMlcyCDyWiB4idnnjh86HcW+rI/psp1XeAmCxP79JYpccu7yp2ax/a
 804=
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="94481981"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2020 22:59:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 29 Oct 2020 22:59:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 29 Oct 2020 22:59:15 -0700
From:   Viswas G <Viswas.G@microchip.com.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <Ruksar.devadi@microchip.com>,
        <martin.petersen@oracle.com>, <yuuzheng@google.com>,
        <vishakhavc@google.com>, <radha@google.com>,
        <akshatzen@google.com>, <jinpu.wang@cloud.ionos.com>
Subject: [PATCH V2 0/4] pm80xx updates 
Date:   Fri, 30 Oct 2020 11:39:09 +0530
Message-ID: <20201030060913.14886-1-Viswas.G@microchip.com.com>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Viswas G <Viswas.G@microchip.com>

This patch set include some bug fixes for pm80xx driver.

Changes from v1:
	- Improved commit message for "make mpi_build_cmd locking
	  consistent.patch"

Viswas G (1):
  pm80xx: make running_req atomic.

akshatzen (1):
  pm80xx: Avoid busywait in FW ready check

peter chang (1):
  pm80xx: make mpi_build_cmd locking consistent

yuuzheng (1):
  pm80xx: make pm8001_mpi_set_nvmd_resp free of race condition

 drivers/scsi/pm8001/pm8001_hwi.c  |  86 +++++++++++++++++++------
 drivers/scsi/pm8001/pm8001_init.c |   2 +-
 drivers/scsi/pm8001/pm8001_sas.c  |  11 ++--
 drivers/scsi/pm8001/pm8001_sas.h  |   2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c  | 130 ++++++++++++++++++++++++++++++--------
 drivers/scsi/pm8001/pm80xx_hwi.h  |   6 ++
 6 files changed, 185 insertions(+), 52 deletions(-)

-- 
2.16.3

