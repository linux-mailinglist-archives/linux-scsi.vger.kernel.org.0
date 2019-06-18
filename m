Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD504A985
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 20:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfFRSLC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 14:11:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39284 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfFRSLC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 14:11:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5II55rJ006562;
        Tue, 18 Jun 2019 11:10:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=ifeEf4z2GJoTH47DHlbvE7kTpXvnNK5cEaKgCNNds00=;
 b=WzzkYsqPF+UuNUEHu/XR1G8EUKhaDJO5TT+clLPp4B6nXC16DcvCANsxaeYpikA1cSVw
 4cux4CFf/2x99uynFOsEULXPonU64jtt/9TbW+MHXpE7v/q0NC4Pscn4px2AekfzNQQl
 uSJ6adaHSq77kwDNkH70cG++HOGOgbxH++9GZ0qAeqEw0eGypkjI2DAwg3OpwJ7Jyhes
 U1BMQ0VY74d0uzgJDCjWtB6rVBubA/AvHsD93+rS7M+1TJ59fiXlVOcVyt03uGVCKp/V
 FagQefo88eTazJTjQ9XwhFcEdCBZ0pG0R8g5tG8H4nNdLW/HD1t7gtgSm+abzWbgGUHa rg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t6xkh1pnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 11:10:56 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 18 Jun
 2019 11:10:45 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 18 Jun 2019 11:10:45 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 9EC7E3F703F;
        Tue, 18 Jun 2019 11:10:45 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5IIAjS0016590;
        Tue, 18 Jun 2019 11:10:45 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5IIAj8j016581;
        Tue, 18 Jun 2019 11:10:45 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 0/3] qla2xxx: Fix crashes with FC-NVMe devices
Date:   Tue, 18 Jun 2019 11:10:18 -0700
Message-ID: <20190618181021.16547-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
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

Changes from v1 -> v2
o Removed now unused qla_is_active_nvme_fcport function.

Arun Easi (1):
  qla2xxx: Fix kernel crash after disconnecting NVMe devices

Quinn Tran (2):
  qla2xxx: on session delete return nvme cmd
  qla2xxx: Fix NVME cmd and LS cmd timeout race condition

 drivers/scsi/qla2xxx/qla_def.h  |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.c | 219 +++++++++++++++++++++++++---------------
 drivers/scsi/qla2xxx/qla_nvme.h |   2 +-
 drivers/scsi/qla2xxx/qla_os.c   |   1 -
 4 files changed, 139 insertions(+), 86 deletions(-)

-- 
2.12.0

