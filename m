Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1407EB8B7
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Nov 2023 22:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjKNVlt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Nov 2023 16:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjKNVls (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Nov 2023 16:41:48 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F30D2;
        Tue, 14 Nov 2023 13:41:45 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cc9b626a96so46182635ad.2;
        Tue, 14 Nov 2023 13:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998105; x=1700602905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94ySD3WcUYe12j9i1bxOC4LnwfgGxbnyqO6cY7D/70w=;
        b=ALz29v72Gsbkz4PNG2h41lEsX+9GGtI3Iv33EsZHaNqCg3HXsT2bBLw5o6BqgNXgo/
         32AxZ93H+YeeREzkv1kMP37SMx3IXV1SJ3e78KlY4Ln+MxdTer11ywZ2pAFLJnJ5VZlm
         WD46G+mawbamT39FW4l3/9WaLWND2id7FR48XQDePk5M17+bnwWRl4H5TVgzyd/M4bzn
         fI8241GN0yTPoeLo+aNMPRC3clxOfZTjIMRZFj6kty06EIbWgzq+/T81FtynVaIXry05
         FP7g/+CfAen2P+lx4q1g4cx+LwppGCvwJ5hQw8WKkuKGPA/j9RkcHgsRJaq7LLMNVYSu
         xaMg==
X-Gm-Message-State: AOJu0Yyf1AKsmz4OrUqaHsIN+BNtgcDIxzUShULSZ9l5tQvNNHjWDGFA
        RJhDyUaFO+FJuQKN0T8Ru033GIIma7w=
X-Google-Smtp-Source: AGHT+IEo1DVuMnTjmx0RDfE1/mCp7Xs//AkZQ8mUt8Cl1PXy/ZmmNHB82DpQwPwmL+8T6v4SC8OFZA==
X-Received: by 2002:a17:902:e74a:b0:1cc:e76e:f214 with SMTP id p10-20020a170902e74a00b001cce76ef214mr3983629plf.29.1699998105116;
        Tue, 14 Nov 2023 13:41:45 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:41:44 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Daejun Park <daejun7.park@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 00/15] Pass data lifetime information to SCSI disk devices
Date:   Tue, 14 Nov 2023 13:40:55 -0800
Message-ID: <20231114214132.1486867-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

UFS vendors need the data lifetime information to achieve good performance.
Providing data lifetime information to UFS devices can result in up to 40%
lower write amplification. Hence this patch series that adds support in F2FS
and also in the block layer for data lifetime information. The SCSI disk (sd)
driver is modified such that it passes write hint information to SCSI devices
via the GROUP NUMBER field.

Please consider this patch series for the next merge window.

Thank you,

Bart.

Changes compared to v3:
 - Renamed the data lifetime constants (WRITE_LIFE_*).
 - Fixed a checkpatch complaint by changing "unsigned" into "unsigned int".
 - Rebased this patch series on top of kernel v6.7-rc1.
 
Changes compared to v2:
 - Instead of storing data lifetime information in bi_ioprio, introduce the
   new struct bio member bi_lifetime and also the struct request member
   'lifetime'.
 - Removed the bio_set_data_lifetime() and bio_get_data_lifetime() functions
   and replaced these with direct assignments.
 - Dropped all changes related to I/O priority.
 - Improved patch descriptions.

Changes compared to v1:
 - Use six bits from the ioprio field for data lifetime information. The
   bio->bi_write_hint / req->write_hint / iocb->ki_hint members that were
   introduced in v1 have been removed again.
 - The F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT fcntls have been removed.
 - In the SCSI disk (sd) driver, query the stream status and check the PERM bit.
 - The GET STREAM STATUS command has been implemented in the scsi_debug driver.

Bart Van Assche (15):
  fs: Rename the kernel-internal data lifetime constants
  fs: Move enum rw_hint into a new header file
  block: Restore data lifetime support in struct bio and struct request
  fs: Restore write hint support
  fs/f2fs: Restore data lifetime support
  scsi: core: Query the Block Limits Extension VPD page
  scsi_proto: Add structures and constants related to I/O groups and
    streams
  sd: Translate data lifetime information
  scsi_debug: Reduce code duplication
  scsi_debug: Support the block limits extension VPD page
  scsi_debug: Rework page code error handling
  scsi_debug: Rework subpage code error handling
  scsi_debug: Implement the IO Advice Hints Grouping mode page
  scsi_debug: Implement GET STREAM STATUS
  scsi_debug: Maintain write statistics per group number

 Documentation/filesystems/f2fs.rst |  70 ++++++++
 block/bio.c                        |   2 +
 block/blk-crypto-fallback.c        |   1 +
 block/blk-merge.c                  |   6 +
 block/blk-mq.c                     |   1 +
 block/bounce.c                     |   1 +
 block/fops.c                       |   3 +
 drivers/scsi/scsi.c                |   2 +
 drivers/scsi/scsi_debug.c          | 247 +++++++++++++++++++++--------
 drivers/scsi/scsi_sysfs.c          |  10 ++
 drivers/scsi/sd.c                  | 111 ++++++++++++-
 drivers/scsi/sd.h                  |   3 +
 fs/f2fs/data.c                     |   2 +
 fs/f2fs/f2fs.h                     |  10 ++
 fs/f2fs/segment.c                  |  99 +++++++++++-
 fs/f2fs/super.c                    |  32 +++-
 fs/fcntl.c                         |   1 +
 fs/inode.c                         |   3 +-
 fs/iomap/buffered-io.c             |   2 +
 fs/iomap/direct-io.c               |   1 +
 fs/mpage.c                         |   1 +
 include/linux/blk-mq.h             |   2 +
 include/linux/blk_types.h          |   2 +
 include/linux/fs.h                 |  16 +-
 include/linux/rw_hint.h            |  20 +++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  75 +++++++++
 27 files changed, 638 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/rw_hint.h

