Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E244917F
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfFQUi4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:38:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44884 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUi4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:38:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so6407579pgp.11
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bzhZ/0bJMlJtKoSR596Xvy5+hf0Ue/caRQu/90SRDE=;
        b=olYCSPqKb9u7HE6Ue47IrE5EuL1csS6JyzsimXlWXpkQLAvtRtSGxKlW17Ngq43lC5
         Fl47UYdQPkY3Ooc9m9jpSEesrqKIO3G8MAUCWh8ZSepWv5QJu2UEbbSklRr3arCWNNFE
         VJzBIz6SwKQNZ3Rt0cLV9A/lHy0re4qt6tQj3DtXZys9G8cjLBFfMyhfgnk+Llt3lECK
         sloTFYW3gliTa3LzjcQIFeS0/oEMTr7NTEerdpeanDC80Nm0DHfty/etFlxxC/Gd9wGi
         6OnM85kptlSBX9vFZJ/gJPSPWPF0f/6RHnVrJn7wtqjjtiMA6gMqRdONXHyebrewQlCW
         xKGg==
X-Gm-Message-State: APjAAAWpnxVBnyvURbTaMsEeva3jhW49VeB4Xcok8c//g1/yaRRBZdQM
        t71FiHdZLjp5J9Ma/0pwNHA=
X-Google-Smtp-Source: APXvYqzVL9LCWgO/3DAY9CnzXfM7mHS7IQrrIEea0tQt/ThIURbD24C5wIJXCGT3F9VmXbuC40tGug==
X-Received: by 2002:a17:90a:601:: with SMTP id j1mr909113pjj.96.1560803935934;
        Mon, 17 Jun 2019 13:38:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.38.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:38:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/6] qla2xxx abort handling fixes
Date:   Mon, 17 Jun 2019 13:38:41 -0700
Message-Id: <20190617203847.184407-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This patch series includes two fixes for patches that went upstream during the
v5.2-r1 merge window and a fix for a race condition in the abort handling code.
Please consider this patch series for kernel v5.3.

Thanks,

Bart.

Bart Van Assche (6):
  qla2xxx: Make qla2x00_abort_srb() again decrease the sp reference
    count
  qla2xxx: Really fix qla2xxx_eh_abort()
  qla2xxx: Enable type checking for the SRB free and done callback
    functions
  qla2xxx: Move the sp->ref_count initialization into
    qla2xxx_get_qpair_sp()
  qla2xxx: Make the code for freeing SRBs more systematic
  qla2xxx: Only free an SRB once the reference count drops to zero

 drivers/scsi/qla2xxx/qla_bsg.c    |  12 +-
 drivers/scsi/qla2xxx/qla_def.h    |  17 +-
 drivers/scsi/qla2xxx/qla_gbl.h    |  15 +-
 drivers/scsi/qla2xxx/qla_gs.c     | 272 +++++++++++++-----------------
 drivers/scsi/qla2xxx/qla_init.c   |  96 +++++------
 drivers/scsi/qla2xxx/qla_inline.h |   1 +
 drivers/scsi/qla2xxx/qla_iocb.c   |  70 ++++----
 drivers/scsi/qla2xxx/qla_mbx.c    |  10 +-
 drivers/scsi/qla2xxx/qla_mid.c    |   6 +-
 drivers/scsi/qla2xxx/qla_mr.c     |   6 +-
 drivers/scsi/qla2xxx/qla_nvme.c   |  45 +++--
 drivers/scsi/qla2xxx/qla_nvme.h   |   2 +-
 drivers/scsi/qla2xxx/qla_os.c     |  98 +++++------
 drivers/scsi/qla2xxx/qla_target.c |   8 +-
 14 files changed, 295 insertions(+), 363 deletions(-)

-- 
2.22.0.rc3

