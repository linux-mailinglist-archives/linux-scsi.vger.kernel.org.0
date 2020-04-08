Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25491A1BFB
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Apr 2020 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHGnm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Apr 2020 02:43:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39212 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgDHGnl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Apr 2020 02:43:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0386f87C025980;
        Tue, 7 Apr 2020 23:43:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Z+WQUqNHI0fxI9lHdL9CFDdEzhkORQBqduTCsTKRUrU=;
 b=PirBoKB954G41r6Id+oHNfxFqpQzd/Zv/Kjlxxq6fSI9YpZ5JzHrabzMLuDyyIXQNeX6
 jUFMjdGVxGi80joCAAYjej9Q3mrS4x0IRVhS604VvSEMKfmwVyYBvERdMyzBk6aYK8We
 +IQbi5U5t0/djIGkU822rDwuLIdystjyZjnr+k1BEmTumaomeqqyHnsnJ6EOFwWL8Gwa
 qy9eKl8jC25KPy0rVtFM5015Nm3haPYgvaUHwy8pHgNxFR04wVf9+9FLsexY5HwfkjZ2
 3MV+SEVzJOa4WBZhmhBHPwpSKtTNKys0S7lvyjhiskPn0SEyJENe+9i2rPcuHtkrhVuT YQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3091me1yjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 23:43:36 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 23:43:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Apr 2020 23:43:34 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 3D1703F7055;
        Tue,  7 Apr 2020 23:43:33 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0386hXF9019412;
        Tue, 7 Apr 2020 23:43:33 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0386hWNf019411;
        Tue, 7 Apr 2020 23:43:32 -0700
From:   Manish Rangankar <mrangankar@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 0/6] Miscellaneous fixes
Date:   Tue, 7 Apr 2020 23:43:26 -0700
Message-ID: <20200408064332.19377-1-mrangankar@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

Please apply the below list of patches to the scsi tree
at your convenience.

Manish Rangankar (4):
  qedi: Remove additional char from boot target iqnname.
  qedi: Avoid unnecessary endpoint allocation on link down
  qedi: Use correct msix count for fastpath vectors.
  qedi: Add modules param to enable qed iSCSI debug.

Nilesh Javali (2):
  qedi: Do not flush offload work if ARP not resolved.
  qedi: Fix termination timeouts in session logout

 drivers/scsi/qedi/qedi_iscsi.c | 17 ++++++++++-------
 drivers/scsi/qedi/qedi_main.c  | 11 +++++++----
 2 files changed, 17 insertions(+), 11 deletions(-)

-- 
1.8.3.1

