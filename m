Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4249A54EFB
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFYMgX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 08:36:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53800 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfFYMgX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561466184; x=1593002184;
  h=from:to:cc:subject:date:message-id;
  bh=Ay9wVdVFJajSIwQVRM69CUSYgXcVzN6PH8ONRrOY0JY=;
  b=XWqfW1ozVDE6r1NW3FlSmKsA8h26fe58blVzWvRLYlCfllTY5bVtoDm9
   uXkoBYgRAxytLDFXEqTTvPr7HCWXu++SoEtTnIatP37YpF2ReVQ7sNl1m
   OG/N78vVsOU4Ae3hgB+EeHZpiZS9IhLtW2yvXBlPlayqEXOX2YrCJ3vTc
   f5fY1tisZ7dw6FnPeXL05bJATxriKVYK8kjhT0UE6kq1vLBjgzu7imXvn
   fgbAqSTdhIHBz8emqAVXwhFuCWt2YgR2IccfXNPtBlXpgvZ56ZtfldSQ/
   uT9WE9YQxcLVWcJ6GGFAWntz1lfsWioRbdQj8afh4fA1K2+TbbbAfl3Xy
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,415,1557158400"; 
   d="scan'208";a="111477526"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 20:36:23 +0800
IronPort-SDR: TyKE23sIidzGkjLx5557mzQd0AbVszdvNV3UwuiTMscxWnne7QtwBeEODisl7S12rC/kBsFP87
 1NYgqPQFabPnTaUQigOixJQ4biUembQhPe5R5F7nDqZNuw9BGiHlu8tDK4XSQ7fh+jdVtYJyk3
 GHN0D4MyjwUAwD868XKFlydkZNMkietVIpqCHKIUf2X5MhA0n0bsJK6R1bmAhYCpubCDbEsGjG
 3OCSMjm3gswQECBawClMJzamQDGiyKp6PhRZMCyAozSj1zh+439NtRD/s7xyvnHRjk6STRyheP
 V2L7YBJptdL/OHnlg8O7Ws76
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jun 2019 05:35:33 -0700
IronPort-SDR: vMn2lcJXdHw5XISN7q2JetnjugwDcdr6PgnT1Lf7ceLQC9XixTXBSb1g16KjEcoOUqYk6Id08W
 9HQPFQZrRh4LHI2hADkjcl90ci0UIM17i7gLzQLdhavQSUbhDgYZSlmleLRQJ3o0QGvegBnU+N
 6FKgdFeU++qhO2H96M1CCDv8aEyPDuy7GMaanvya038643K48TrrAaL+mhdyZiPD+qhrn5sKaN
 pS363ctgXeW7eH+lxCPk+0uw/hGAVNzrPeKYJLZa8sX1dhFDPatr/xqMFhC1GZLecIl7TOHeKQ
 EhU=
Received: from ilb001078.sdcorp.global.sandisk.com ([10.0.231.241])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2019 05:36:17 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-@vger.kernel.org,
        kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Arthur Simchaev <Arthur.Simchaev@sandisk.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Date:   Tue, 25 Jun 2019 15:36:00 +0300
Message-Id: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arthur Simchaev <Arthur.Simchaev@sandisk.com>

The ufs-tool stable release v1.0 is available at
https://github.com/westerndigitalcorporation/ufs-tool

Feedback and bug reports, as always, are welcomed.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 Documentation/scsi/ufs.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt
index 1769f71..ae4643f 100644
--- a/Documentation/scsi/ufs.txt
+++ b/Documentation/scsi/ufs.txt
@@ -158,6 +158,11 @@ send SG_IO with the applicable sg_io_v4:
 If you wish to read or write a descriptor, use the appropriate xferp of
 sg_io_v4.
 
+The user-space tool that interacts with the ufs-bsg endpoint and uses its
+upiu-based protocol, is available at
+https://github.com/westerndigitalcorporation/ufs-tool.
+For more detailed information about the tool and the tool's supported
+features, please see the tool's README.
 
 UFS Specifications can be found at,
 UFS - http://www.jedec.org/sites/default/files/docs/JESD220.pdf
-- 
2.7.4

