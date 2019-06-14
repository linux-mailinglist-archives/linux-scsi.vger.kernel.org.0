Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26F646C35
	for <lists+linux-scsi@lfdr.de>; Sat, 15 Jun 2019 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfFNWK0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 18:10:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60466 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfFNWK0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 18:10:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EM7UXV008165;
        Fri, 14 Jun 2019 15:10:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=SfDfNdoh9rQLNhetxCyrsBhl3TtaOAplTD6hOyWMTSo=;
 b=cqZwV3MXpgBufmFOZjvB2ZYsMH+51rUJm/KaU9clQV+4cVuE5JprBhLskEGIhElu4zzg
 bcN+j3NTtW8LhHc8NYeKsJewP4aEhzzOxgncF2oIsQnw+BuD0GXHw6C92x0I0xk1AjHp
 R52I4laFLwclr4UKNCHd61rPFnpf7z7jDOiRcl1aasqBKahcGjTQdtReAEBMnGaMLaCB
 PzUIKoMUhTchbyU//Kyhry0/NIIhiwI/Plkkp/N6pkbbv/QRbRDgxUtRllYq1nsUGuTG
 uU7kcGLnufBofoRI6O7g26yabVHbofHm1KAyyr1ctPHuogm4PPONka2B6NLvPYVc+M2C 1A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3hvq01ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 15:10:22 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 15:10:21 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 14 Jun 2019 15:10:21 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C310A3F703F;
        Fri, 14 Jun 2019 15:10:20 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5EMAKql019208;
        Fri, 14 Jun 2019 15:10:20 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5EMAKaG019207;
        Fri, 14 Jun 2019 15:10:20 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 0/3] qla2xxx: Fix crashes with FC-NVMe devices 
Date:   Fri, 14 Jun 2019 15:10:17 -0700
Message-ID: <20190614221020.19173-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This series fixes crash during abort handling with FC-NVMe devices. 
Also, we discovered race condition between nvme command and ls completion
with FC-NVMe devices.

Please apply this series to 5.3/scsi-queue at your earliest convenience.

Thanks,
Himanshu

Arun Easi (1):
  qla2xxx: Fix kernel crash after disconnecting NVMe devices

Quinn Tran (2):
  qla2xxx: on session delete return nvme cmd
  qla2xxx: Fix NVME cmd and LS cmd timeout race condition

 drivers/scsi/qla2xxx/qla_def.h  |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.c | 234 ++++++++++++++++++++++++++--------------
 drivers/scsi/qla2xxx/qla_nvme.h |   2 +-
 drivers/scsi/qla2xxx/qla_os.c   |   1 -
 4 files changed, 154 insertions(+), 86 deletions(-)

-- 
2.12.0

