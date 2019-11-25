Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77182109201
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Nov 2019 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfKYQkO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Nov 2019 11:40:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728683AbfKYQkO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Nov 2019 11:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574700013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7d/alvV8xnbFsyraVnnMUsU6a4j1+nXaSv6ic6vU9Ds=;
        b=OLZdxykHWg1+TRhXYbj7ftLauzZlpRgCW2jUiUSoGJ/gHNrxdPe1UjZYh5k0T2RxeINYHW
        5t5rvo77gC4Q5WZWbQ+4d1eulRYmlxHpEQFo1wVh/V9V8vAarWDTlO1p4U6oj0G+lNV3GL
        NOHJTMsFhxCcQ54g6Kaaslsa4dYahHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-5cprpppJPsiXxTftAzv5Nw-1; Mon, 25 Nov 2019 11:40:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF879107B276;
        Mon, 25 Nov 2019 16:40:08 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11EAC5C219;
        Mon, 25 Nov 2019 16:40:07 +0000 (UTC)
Message-ID: <44cc15adc190fb1f6f89cbb8478aadda35f6b1e2.camel@redhat.com>
Subject: Re: [PATCH] scsi: lpfc: Move work items to a stack list
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>,
        James Smart <james.smart@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-scsi@vger.kernel.org
Date:   Mon, 25 Nov 2019 11:40:07 -0500
In-Reply-To: <20191119181435.taxa56wbf4zd4f2f@beryllium.lan>
References: <20191105080855.16881-1-dwagner@suse.de>
         <yq1h838pivf.fsf@oracle.com>
         <20191119132854.mwkxx4fixjaoxv4w@beryllium.lan>
         <4a1fedc9-03f1-7312-fd50-a041a78c0294@broadcom.com>
         <20191119181435.taxa56wbf4zd4f2f@beryllium.lan>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5cprpppJPsiXxTftAzv5Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

[ removed linux-kernel from cc: ]

We may have hit the same issue in testing, we're looking at it.

-Ewan

