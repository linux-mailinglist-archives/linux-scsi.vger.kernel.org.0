Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5836380C46
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhENOwe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 10:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232925AbhENOwe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 May 2021 10:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621003882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7lnyrVxrKCeS9lmLwvsQ2mZdlXcr6J3wCh/5f6LzYs=;
        b=EV5GzHkicxKLJIzgp4tNX5fFyTpZYxhsNrRlDpMMYmiDRs/SC3UExD8jY/caXwFOt7r7tl
        pHpivDSlyIRxpkPkuaXnkDNBTHxQwJ7gYCJs5UydAKyR/275SIfdbWO8okc7xuyfT6XhHe
        eTWUD4v6GZTxNZb/dqWl3W37EwkaXpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-I7uSMQn8N1aUJapYckXtog-1; Fri, 14 May 2021 10:51:18 -0400
X-MC-Unique: I7uSMQn8N1aUJapYckXtog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D7B10CE787;
        Fri, 14 May 2021 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 977C72BFE6;
        Fri, 14 May 2021 14:51:15 +0000 (UTC)
Subject: Re: [PATCH v5 13/24] mpi3mr: implement scsi error handler hooks
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com,
        hare@suse.de
References: <20210513083608.2243297-1-kashyap.desai@broadcom.com>
 <20210513083608.2243297-14-kashyap.desai@broadcom.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <5abd5bc2-3792-84ae-db68-742270ecd7e3@redhat.com>
Date:   Fri, 14 May 2021 16:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513083608.2243297-14-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/13/21 10:35 AM, Kashyap Desai wrote:
> SCSI EH hook is added.
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> 

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Regards,
Tomas

