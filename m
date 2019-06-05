Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A073652D
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 22:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEUOo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 16:14:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32809 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEUOo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 16:14:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so10113968plq.0
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 13:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At2/eQm5JeCtOtkCWVp1an334cPTOQGwgnfaQFC62Ds=;
        b=O7kYjFZbIvbA71e9RMeuTZjV0eC+jCmDYExgik2mDxGESqtJGGHSAgBPwqg0XygDuj
         9nmRKfe7oYutjYd3vMImSMkbAI14msPvsiqVhe24FFfknoawl24AhNYspdkhumMXGZ72
         QDEkctxc2fDSfdeK65TpJpQGhQJI82vtbId1LHw8vpHpMXwoyx8Mbhlg3vCE06UDwNqT
         clXsBjtpQsLSM2tODlmUksm/kbeIvpPftgztdx8mmhRXXnT3x3HxZJqaxyvNk4Ot/eWt
         2EXlJ0LD48SDPJmfuMVMun2W7RwPR1NeRkdUMvtBySDRbLYe8QUOgeGQEFuw7//kv34A
         s9sg==
X-Gm-Message-State: APjAAAVyewKoP2a84fnlKpzNRxXdPk74AKWeUJ8T1I7y/hsnoR23WqNF
        72STcsbLljT4LEiJv3zvafw=
X-Google-Smtp-Source: APXvYqwxQoaAgtkSDEZMSZmNVc8x1xQUb3sScWfJlc23gRRIYievVkiRpzQUdeFMyVE3sjgt+Fnzjw==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7mr29770633plo.124.1559765683432;
        Wed, 05 Jun 2019 13:14:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c129sm27135926pfa.106.2019.06.05.13.14.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:14:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Avoid that .queuecommand() gets called for a quiesced SCSI device
Date:   Wed,  5 Jun 2019 13:14:32 -0700
Message-Id: <20190605201435.233701-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

As explained in a recent LSF/MM topic proposal, it can happen that the SCSI
error handler calls .queuecommand() for a blocked SCSI device. SCSI LLDs do
not expect this. Hence this patch series. Please consider this series for
kernel v5.3.

Thanks,

Bart.

Changes compared to v2:
- Added a patch that converts SDEV_BLOCK into SDEV_QUIESCE for requests
  received through sysfs to change the SCSI device state.

Changes compared to v1:
- Wait on SDEV_BLOCK instead of SDEV_QUIESCE in the SCSI error handler.

Bart Van Assche (3):
  scsi: Do not allow user space to change the SCSI device state into
    SDEV_BLOCK
  scsi: Avoid that .queuecommand() gets called for a quiesced SCSI
    device
  RDMA/srp: Fix a sleep-in-invalid-context bug

 drivers/infiniband/ulp/srp/ib_srp.c | 21 ++-------------------
 drivers/scsi/scsi_error.c           | 26 ++++++++++++++++++++++++--
 drivers/scsi/scsi_sysfs.c           |  7 +++++++
 3 files changed, 33 insertions(+), 21 deletions(-)

-- 
2.22.0.rc3

