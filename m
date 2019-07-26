Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B170676F53
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfGZQtE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:49:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44443 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfGZQtE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 12:49:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so24937931plr.11
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 09:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MzU6lHvR70cXA0a6i+OnCWn4gZxSvyFvbE7WpbszpI=;
        b=gSbF90RZROLphTxljopL2kZGPAXuOAMlYLhZISs+pjDccqXbg51F72TIz4pPkYNG62
         zD/vjMCVHWKEP/Tr/u24YpgNMTG0IpHn4s1JKGH/Z2O7cn7yJR1QLWDM6GMCAqPaM0Qo
         fCPLVNWy9MdjtZoLHkDQ2y7/xYELN6zq+gSurgg1fjAPi97vsDS+cvIyZlmrfym90Z2M
         w4xwngn5X6zbJffMsT2/6QKkiQdhD6CbslBejI9MLqlkuZdXfB5nUcUaPdAD9io7FoeF
         Wn5IFFHt3X+NwGpSsIddYOsg3+oP7RfrpHGTHktkL6vNTcSGxWH1fsfZg04audYbVhK/
         B6Mw==
X-Gm-Message-State: APjAAAUQiWXFrCkJbqwQljVxiKL5jF9P7ml+W+etsdLauLA0jBnjro7w
        dfZ1wOtLfQ/6gCA//IaA+pc=
X-Google-Smtp-Source: APXvYqwEAYHR1u6MGNY9LF54qvFrGCWEnM0hbdPsJRA0DOMvdV9zfmZpsuBLfrVV5WAuEub0hT8ZGA==
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr96372902plt.255.1564159743281;
        Fri, 26 Jul 2019 09:49:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b36sm80923246pjc.16.2019.07.26.09.49.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:49:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] SCSI core patches for kernel v5.4
Date:   Fri, 26 Jul 2019 09:48:51 -0700
Message-Id: <20190726164855.130084-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

The patches in this series improve the robustness of SCSI device blocking and
unblocking and fix a boot failure. Please consider these patches for kernel
version v5.4.

Thanks,

Bart.

Bart Van Assche (4):
  Make scsi_internal_device_unblock_nowait() reject invalid new_state
    values
  Change the return type of scsi_target_block() from 'void' into 'int'
  Complain if scsi_target_block() fails
  Reduce memory required for SCSI logging

 drivers/scsi/scsi_lib.c     | 34 ++++++++++++++++++++------
 drivers/scsi/scsi_logging.c | 48 +++----------------------------------
 include/scsi/scsi_dbg.h     |  2 --
 include/scsi/scsi_device.h  |  2 +-
 4 files changed, 31 insertions(+), 55 deletions(-)

-- 
2.22.0.709.g102302147b-goog

