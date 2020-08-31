Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9332A2571F2
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 04:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHaCyS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Aug 2020 22:54:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41588 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgHaCyO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Aug 2020 22:54:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id t9so3766879pfq.8
        for <linux-scsi@vger.kernel.org>; Sun, 30 Aug 2020 19:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QJfcSZkg0GwS1gdT+HrJeHUZS+JFQJkkIZVE9XrBs0=;
        b=oHwSEpWleBH3x9SdxRkZzJ79Ke6GAoPLmKtB3Utcj/W5+4UesclXE3cD4rsxMQU15o
         9fQ02Hzx8YClbRxDR2D/jnaLywNXsBWi4LpQ97tX0jiXebaEFEkzXJMZeDUBIkgY99Gr
         KxABuTzoi5OEzvFC++XpPVThGJBYvTHBUQEdf9aL8cRZQP21g6/Sio2RR/SnhlTQRvEC
         H+nmHAKBEmgfuaZQPGo+YvxWcNdkTaRsDfimbUa8nz6bEJES/6+sOR9IthILFRAhkbNv
         3yU38i0lTO1yhQZZaSlYa/OLVmY+2Re74x7zlRSDanH9wwHzzQRyf6+hIRXLI/vhjx2x
         TxkA==
X-Gm-Message-State: AOAM530yckgAZI4NnbZIRFfT9y8iI8t59mA4rBBhRZxq21EvJWBH/fjN
        CKKYvygjTpKbO5VhQY6OuJU=
X-Google-Smtp-Source: ABdhPJxTpXXkfIo6TDJMcPTvX4jYUIZTd9+anfF7Ql2P5RM1yta/5YIEkpI7A2TopgUqjMJws3TFGg==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr6672623pgc.147.1598842446829;
        Sun, 30 Aug 2020 19:54:06 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l123sm583569pgl.24.2020.08.30.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 19:54:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-scsi@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Can Guo <cang@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH RFC 0/6] Fix a deadlock in the SCSI power management code
Date:   Sun, 30 Aug 2020 19:53:51 -0700
Message-Id: <20200831025357.32700-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Recently Martin Kepplinger reported a problem with the SCSI runtime PM
code. Alan Stern root-caused the reported deadlock. This patch series is
an attempt to fix that deadlock. These patches compile but have not yet
been tested.

Bart Van Assche (6):
  ide: Do not set the RQF_PREEMPT flag for sense requests
  scsi: Remove an incorrect comment
  scsi: Pass a request queue pointer to __scsi_execute()
  scsi_transport_spi: Make spi_execute() accept a request queue pointer
  scsi_transport_spi: Freeze request queues instead of quiescing
  block, scsi, ide: Only submit power management requests in state
    RPM_SUSPENDED

 block/blk-core.c                  |   6 +-
 block/blk-mq-debugfs.c            |   1 -
 block/blk-mq.c                    |   4 +-
 drivers/ide/ide-atapi.c           |   1 -
 drivers/ide/ide-io.c              |   3 +-
 drivers/ide/ide-pm.c              |   2 +-
 drivers/scsi/scsi_lib.c           |  61 ++++++++-------
 drivers/scsi/scsi_priv.h          |   2 +
 drivers/scsi/scsi_transport_spi.c | 123 +++++++++++++++++-------------
 include/linux/blk-mq.h            |   4 +-
 include/linux/blkdev.h            |   6 +-
 include/scsi/scsi_device.h        |  16 ++--
 12 files changed, 120 insertions(+), 109 deletions(-)

