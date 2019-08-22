Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B899604
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfHVOLh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 10:11:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732137AbfHVOLg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 10:11:36 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7BC8AFDFA07AC5184D9F;
        Thu, 22 Aug 2019 22:11:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:11:14 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 0/4] scsi: bfa: remove some set but not used variables
Date:   Thu, 22 Aug 2019 22:17:42 +0800
Message-ID: <1566483466-120175-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

zhengbin (4):
  scsi: bfa: remove set but not used variable 'fchs'
  scsi: bfa: remove set but not used variable 'rp'
  scsi: bfa: remove set but not used variable 'adisc'
  scsi: bfa: remove set but not used variable 'pgoff'

 drivers/scsi/bfa/bfa_fcpim.c     |  3 ---
 drivers/scsi/bfa/bfa_fcs_rport.c |  3 ---
 drivers/scsi/bfa/bfa_ioc.c       | 16 +++++-----------
 drivers/scsi/bfa/bfa_svc.c       |  3 ---
 4 files changed, 5 insertions(+), 20 deletions(-)

--
2.7.4

