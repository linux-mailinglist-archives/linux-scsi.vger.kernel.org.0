Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFC9A14C
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 22:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393303AbfHVUjl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 16:39:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33189 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393297AbfHVUjl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Aug 2019 16:39:41 -0400
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa6.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
IronPort-SDR: hzGFKoKfhzxHIWQF0OZex4LVLD/moJfc/9OzE0ZXhcsg/wNKPnELjNSQ6iJ6dE9b8lMLyyhguj
 i2YnBvYnCEPDn+UFSTVqkraiP+ZFo30kAHbIey+NxdyPdAJoYE+6ru1aNkEEXOpH38guxDCxQg
 lEMLz7GocxnPH2fVDd0/kiYXclfjj98KDTTUlvbPlq+v7OtVO2cJCu0dk0lEHubzjfm1tvbudj
 p8CNGXb5bvsD3KPZ/zok2+YpCJRufCeOGFkqSoBEwEsBkSHMfp7b+Sd36DcKfX3HqPioDEG+Kk
 5+M=
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; 
   d="scan'208";a="43343500"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2019 13:39:40 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 22 Aug
 2019 13:39:39 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 22 Aug
 2019 13:39:38 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 22 Aug 2019 13:39:38 -0700
Subject: [PATCH 07/11] smartpqi: add gigabyte controller
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Thu, 22 Aug 2019 15:39:38 -0500
Message-ID: <156650637808.18562.8472588324054460708.stgit@brunhilda>
In-Reply-To: <156650628375.18562.9889154437665249418.stgit@brunhilda>
References: <156650628375.18562.9889154437665249418.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Gilbert Wu <gilbert.wu@microsemi.com>

Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Gilbert Wu <gilbert.wu@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 9801606dadfa..159e9cfc2996 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -8400,6 +8400,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1d8d, 0x0916)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_GIGABYTE, 0x1000)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_ANY_ID, PCI_ANY_ID)

