Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F1A3666A3
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhDUIDM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 04:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234152AbhDUICZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 04:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618992112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1RkcM8XmR64QBQSFo7rPNVfwwQ1KW863sEHKTqb4UEE=;
        b=ghlWx8/C1eggsS+/QkduQrOBpY9ZjFuhb9YnELSeFcBmYr5FTsck9yoMZwImKGLY17o0Y8
        cwZVpFAbSpquRd8dxQGYAIuaVEno1dOTK7JRfIm3eoE+RhW+6bZT4YYV8NxQkUOmF92s71
        yZc70QOk0KO8oqBDoHfKtMcQHwLwpxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-gaLitj7NMT-aMCHm_88FNg-1; Wed, 21 Apr 2021 04:01:50 -0400
X-MC-Unique: gaLitj7NMT-aMCHm_88FNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 007AC824FB8;
        Wed, 21 Apr 2021 07:57:06 +0000 (UTC)
Received: from localhost (ovpn-13-15.pek2.redhat.com [10.72.13.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0AA560CDE;
        Wed, 21 Apr 2021 07:57:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Satish Kharat <satishkh@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        David Jeffery <djeffery@redhat.com>
Subject: [PATCH 0/5] scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands
Date:   Wed, 21 Apr 2021 15:55:38 +0800
Message-Id: <20210421075543.1919826-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello Guys,

fnic uses the following way to walk scsi commands in failure handling,
which is obvious wrong, because caller of scsi_host_find_tag has to
guarantee that the tag is active.

        for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
				...
                sc = scsi_host_find_tag(fnic->lport->host, tag);
				...
		}

Fix the issue by using blk_mq_tagset_busy_iter() to walk
request/scsi_command.

thanks,
Ming


Ming Lei (5):
  scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
    fnic_terminate_rport_io
  scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
    fnic_clean_pending_aborts
  scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
    fnic_cleanup_io
  scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
    fnic_rport_exch_reset
  scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
    fnic_is_abts_pending

 drivers/scsi/fnic/fnic_scsi.c | 933 ++++++++++++++++++----------------
 1 file changed, 493 insertions(+), 440 deletions(-)

Cc: Satish Kharat <satishkh@cisco.com>
Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: David Jeffery <djeffery@redhat.com>

-- 
2.29.2

