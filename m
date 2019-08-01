Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0767E5C1
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 00:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbfHAWiY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 18:38:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39957 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbfHAWiX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 18:38:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so32764487pla.7
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 15:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIO0UMe6GE8J7w6NnmmmZQwKUdlJvclnKLD3DpoWw5c=;
        b=TnFUejsJADQMyNXakXzfhPveXInNSwGuekeYPuDRK5jfKW9cqXExDWI9bnWEZx20n2
         NkoOI7fO7bk7NF4XKdWPF9czv5UzqnQu5HJ24ymXLIg1kcaJEmGMpREIMie4zYObZLSd
         DNm28nVscJGEy9EoMSw6ordWdjjclg3mGRyMnoc786DwXyYO7awhXHahiPpTLnNctxz4
         v26Qvzqtq3fCPGkzcWh8RSkLPvWYvQPk7kUkNEg416cfAYxMMWVEcBgotJRqTRIfKmkM
         eCX6WECNOQCEJD15LVx8kSQaSnsArhzuN201+TfCtOBoRmv0kuD1Fn/P3qywmjD5FrzL
         mtJQ==
X-Gm-Message-State: APjAAAVO8FMXiX8JmnNfsNnLX6UcgA/soxf8vng0FjvnF2GZGWW1RLlL
        oLVaA3p6nsVij/SK9FGNro0=
X-Google-Smtp-Source: APXvYqzQ/mrC/Z0u3K72TaY5w3Cjr9xxlrOXKbyL6h7I3j42TXWcQCsc9kYO47zSNryJUaKrsIlasQ==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr117197302plv.209.1564699102593;
        Thu, 01 Aug 2019 15:38:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b26sm82344632pfo.129.2019.08.01.15.38.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:38:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] SCSI core patches for kernel v5.4
Date:   Thu,  1 Aug 2019 15:38:11 -0700
Message-Id: <20190801223814.140729-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

The patches in this series address SCSI device blocking and unblocking and fix
a boot failure. Please consider these patches for kernel version v5.4.

Thanks,

Bart.

Changes compared to v1:
- As requested by James, dropped the patch that changes the return type of
  scsi_target_block() and moved the WARN_ONCE() statement into device_block().

Bart Van Assche (3):
  Make scsi_internal_device_unblock_nowait() reject invalid new_state
    values
  Complain if scsi_target_block() fails
  Reduce memory required for SCSI logging

 drivers/scsi/scsi_lib.c     | 15 +++++++++++-
 drivers/scsi/scsi_logging.c | 48 +++----------------------------------
 include/scsi/scsi_dbg.h     |  2 --
 3 files changed, 17 insertions(+), 48 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

