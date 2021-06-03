Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D109399E36
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Jun 2021 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCJ6s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Jun 2021 05:58:48 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:48896 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFCJ6s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Jun 2021 05:58:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1539p88T005747
        for <linux-scsi@vger.kernel.org>; Thu, 3 Jun 2021 02:57:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=yLL+Xxqcqnev5qwWZwQffjXIrrGZo6EP3JJ8wzOvzOM=;
 b=isbAN/ui6PfDK9vRRrs+me0B23FkowsA4EALpi25u3PO9jUDXiy3kO0ZgHflkHpfVz1P
 Pimhx0rGaiAUcRBCA0bokiPkj4WkgaAnhKm11egvUV01RAKh2FMXoqHHLafoYYKXdl4h
 sGpdlnXv2JQFbrIBNVrb7kE/paL6yX43HQjaj+Q+oj/G/s44dnBxQr+F8LW/FaZrtwGJ
 OG+i7fDOQH7u3FvBtiVXD/wrpIBxOJPYO6k86gGGqSy5aiSawg1Vk17L/r+bPlw+DxON
 /wYm/JFvwzS6IyguVOW+o18hDHyhhDLZ75rPhdBwamAgeXstNsXIAbOGgZpbYakFO1Q/ UQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 38xhym24c4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 03 Jun 2021 02:57:03 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 02:57:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Jun 2021 02:57:01 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id A40C83F7041;
        Thu,  3 Jun 2021 02:57:01 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1539v1VL007362;
        Thu, 3 Jun 2021 02:57:01 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1539v18g007353;
        Thu, 3 Jun 2021 02:57:01 -0700
From:   Javed Hasan <jhasan@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <jhasan@marvell.com>
Subject: [PATCH 0/2] scsi: FDMI Fixes
Date:   Thu, 3 Jun 2021 02:56:35 -0700
Message-ID: <20210603095637.7319-1-jhasan@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dy6RC6R0vuBHbgZ9iG8_J3o4kYisFVe3
X-Proofpoint-GUID: dy6RC6R0vuBHbgZ9iG8_J3o4kYisFVe3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_06:2021-06-02,2021-06-03 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series has two fixes for FDMI.
Attributes length corrected for RHBA.
Fixed the wrong condition check in fc_ct_ms_fill_attr().

Kindly apply this series to scsi-queue at your earliest convenience.

Javed Hasan (2):
  scsi: fc: Corrected RHBA attributes length
  libfc: Corrected the condition check and invalid argument passed

 drivers/scsi/libfc/fc_encode.h | 8 +++++---
 include/scsi/fc/fc_ms.h        | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.26.2

