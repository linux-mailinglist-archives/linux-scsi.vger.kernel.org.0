Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6901041A3
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Nov 2019 18:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfKTRAd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Nov 2019 12:00:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728460AbfKTRAd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Nov 2019 12:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574269232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cvz2Q4GLLXCvvkELyY3QsZNPG74+YhN9vdrAtOQhB4U=;
        b=i34jz1Xd3CR8Vg090WW5OBigH17+9bGSbYcTSyaDlMy1Fe7ZdSKkkixfutIGQujFKhpVoU
        FXS6LmUgqaVzs+wro/XYDe0qGHVeTiJgqDmENfmOhG881pm1pdqEPgTAQREl8alzOzdtba
        Mc3loqrU6I8NHk+/thtWWLdUtQP+opw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-2gSBOrfBPlqSRPsWeRUiDw-1; Wed, 20 Nov 2019 12:00:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 267D980269C;
        Wed, 20 Nov 2019 17:00:26 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5110D19EE8;
        Wed, 20 Nov 2019 17:00:20 +0000 (UTC)
Message-ID: <9bbcbbb42b659c323c9e0d74aa9b062a3f517d1f.camel@redhat.com>
Subject: Re: [PATCH 4/4] scsi: core: don't limit per-LUN queue depth for SSD
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Date:   Wed, 20 Nov 2019 12:00:19 -0500
In-Reply-To: <1081145f-3e17-9bc1-2332-50a4b5621ef7@suse.de>
References: <20191118103117.978-1-ming.lei@redhat.com>
         <20191118103117.978-5-ming.lei@redhat.com>
         <1081145f-3e17-9bc1-2332-50a4b5621ef7@suse.de>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2gSBOrfBPlqSRPsWeRUiDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2019-11-20 at 11:05 +0100, Hannes Reinecke wrote:
>=20
> Hmm.
>=20
> I must admit I patently don't like this explicit dependency on
> blk_nonrot(). Having a conditional counter is just an open invitation to
> getting things wrong...
>=20

This concerns me as well, it seems like the SCSI ML should have it's
own per-device attribute if we actually need to control this per-device
instead of on a per-host or per-driver basis.  And it seems like this
is something that is specific to high-performance drivers, so changing
the way this works for all drivers seems a bit much.

Ordinarily I'd prefer a host template attribute as Sumanesh proposed,
but I dislike wrapping the examination of that and the queue flag in
a macro that makes it not obvious how the behavior is affected.
(Plus Hannes just submitted submitted the patches to remove .use_cmd_list,
which was another piece of ML functionality used by only a few drivers.)

Ming's patch does freeze the queue if NONROT is changed by sysfs, but
the flag can be changed by other kernel code, e.g. sd_revalidate_disk()
clears it and then calls sd_read_block_characteristics() which may set
it again.  So it's not clear to me how reliable this is.

-Ewan

