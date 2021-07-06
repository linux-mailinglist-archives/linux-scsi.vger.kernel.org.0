Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70A3BDCE7
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Jul 2021 20:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhGFSTE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Jul 2021 14:19:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6083 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhGFSS7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Jul 2021 14:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625595380; x=1657131380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ldqiC7CNWigza5Hejv0x/2uNN/zOYOOFUpjvptBNJBE=;
  b=RXgWp+yxaXFNZ0a4vlvE0w3HQHJfemCqEBZe8qNPUbZUDG09jDcIlI6o
   JoTKSt1AUE1kUT4VVSxzsNQ9whUPEkz7cMfjpI8CJUVhb0SbuHgtGXlHy
   DyFyEz59kadHrHsbkm0DTjcUgY8Mcvtz+kzKSVuvTImrOdeKHAbWwIj18
   R3qMRlc11QSRB3S6+267lbk79A8/PtuZZrItI0ckLsri2sW9Y6jYMeRZp
   hc6hm20wJ7bl3fKLnJd0KrVS8INP5SRFEZ0yu7VmqyyBXgjUhpgK4O3bp
   D8MCHpZYqXa9PcqI1VzBwTql2oRfNHfluGAz/RYKz83QFWvKN2Tk9IhIy
   A==;
IronPort-SDR: UxK+95aAWgU3EKHmOqoYDBlqA3ILiPq+0bg/iDSpXQgSza46XjL53AbEpMoDxbg4QWG12ejKAi
 xtdb3RrZx6nDijNT2aGScpXc0+6D9rM3326F2iMRcBaWfelzMMb9Cp6g92fyr34v5s/mJTgLyR
 TmHmdqiOrLz1yilluFseo4xjFwNiToMqHq4B9n3XSDrbRx7bB3PzEZJdZPLwIsYv5NlD/kXAuU
 4lzVqnFAbseapx6rZqtrIb2kRFH4b9iFUdNq+fq+hfsRMQbDL2N5VnetXW7UqKnzhhhrOo0vmj
 WB0=
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="127846838"
Received: from f5out.microchip.com (HELO smtp.microsemi.com) ([198.175.253.81])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2021 11:16:20 -0700
Received: from AUSMBX1.microsemi.net (10.10.76.217) by AVMBX1.microsemi.net
 (10.10.46.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Jul 2021
 11:16:18 -0700
Received: from brunhilda.pdev.net (10.238.32.34) by ausmbx1.microsemi.net
 (10.10.76.217) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 6 Jul 2021 11:16:18 -0700
Received: by brunhilda.pdev.net (Postfix, from userid 1467)
        id 7DABF702753; Tue,  6 Jul 2021 13:16:18 -0500 (CDT)
From:   Don Brace <don.brace@microchip.com>
To:     <hch@infradead.org>, <martin.peterson@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linux-scsi@vger.kernel.org>
CC:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <murthy.bhat@microchip.com>,
        <balsundar.p@microchip.com>, <joseph.szczypek@hpe.com>,
        <jeff@canonical.com>, <POSWALD@suse.com>,
        <john.p.donnelly@oracle.com>, <mwilck@suse.com>,
        <pmenzel@molgen.mpg.de>, <linux-kernel@vger.kernel.org>
Subject: [smartpqi updates  PATCH 7/9] smartpqi: add PCI IDs for new ZTE controllers
Date:   Tue, 6 Jul 2021 13:16:16 -0500
Message-ID: <20210706181618.27960-8-don.brace@microchip.com>
X-Mailer: git-send-email 2.28.0.rc1.9.ge7ae437ac1
In-Reply-To: <20210706181618.27960-1-don.brace@microchip.com>
References: <20210706181618.27960-1-don.brace@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Balsundar P <balsundar.p@microchip.com>

Added support for ZTE RM241-18i 2G device ID.
VID_9005, DID_028F, SVID_1CF2 and SDID_5445

Added support for ZTE RM242-18i 4G device ID.
VID_9005, DID_028F, SVID_1CF2 and SDID_5446

Added support for ZTE RM243-18i device ID.
VID_9005, DID_028F, SVID_1CF2 and SDID_5447

Added support for ZTE SDPSA/B-18i 4G device ID.
VID_9005, DID_028F, SVID_1CF2 and SDID_0B27

Added support for ZTE SDPSA/B_I-18i device ID.
VID_9005, DID_028F, SVID_1CF2 and SDID_0B29

Added support for ZTE SDPSA/B_L-18i 2G device ID.
VID_9005, DID_028F, SVID_1CF2 and SDID_0B45

Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Signed-off-by: Balsundar P <balsundar.p@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index a8dfb6101830..6f2263abaa8c 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -9182,6 +9182,30 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1dfc, 0x3161)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1cf2, 0x5445)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1cf2, 0x5446)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1cf2, 0x5447)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1cf2, 0x0b27)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1cf2, 0x0b29)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1cf2, 0x0b45)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_ANY_ID, PCI_ANY_ID)
-- 
2.28.0.rc1.9.ge7ae437ac1

