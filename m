Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7525509A
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Aug 2020 23:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgH0Vdh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 17:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50532 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgH0Vdh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Aug 2020 17:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598564016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=iuK6RD7YDUH5xEji+J6jQ2AzGe2jQ8WSTjlhESaE7Xs=;
        b=drbcAsQmGCw29MHpfKVALtZ0hh4xipSpdbV9OKRuc5WKqzxSdL2JdZcBd1BlJTYxjWbnjD
        DHinoqQZpybDq/YUePUsYQ2sdE1HJe58moLavU6C40vDMSVhThGCle3QSANofkQUU5xzqk
        MtgDNGN2bne99LMskZUitYsKcQ/1A/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-k3ye3dGCNY6IrPI1rfp1TQ-1; Thu, 27 Aug 2020 17:33:34 -0400
X-MC-Unique: k3ye3dGCNY6IrPI1rfp1TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE1CA191E2A0;
        Thu, 27 Aug 2020 21:33:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-221.rdu2.redhat.com [10.10.114.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F13078401;
        Thu, 27 Aug 2020 21:33:32 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, djeffery@redhat.com, linux-scsi@vger.kernel.org
Subject: [PATCH 0/2] scsi_debug: improve num_parts usage
Date:   Thu, 27 Aug 2020 17:33:25 -0400
Message-Id: <20200827213327.25537-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hello,

The 1st patch sets all partitions to the same size when using the
num_parts parameter.

The 2nd patch allows virtual_gb to be respected when it is passed at
the same time as num_parts.

John Pittman (2):
 scsi: scsi_debug: adjust num_parts to create equally sized partitions
 scsi: scsi_debug: sdebug_build_parts() respect virtual_gb

scsi_debug.c |   13 ++++++++-----
1 file changed, 8 insertions(+), 5 deletions(-)

