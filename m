Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D109239B98
	for <lists+linux-scsi@lfdr.de>; Sat,  8 Jun 2019 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFHH4R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Jun 2019 03:56:17 -0400
Received: from verein.lst.de ([213.95.11.211]:60510 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfFHH4Q (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 8 Jun 2019 03:56:16 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 07A5B68B02; Sat,  8 Jun 2019 09:55:49 +0200 (CEST)
Date:   Sat, 8 Jun 2019 09:55:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V3 1/3] scsi: lib/sg_pool.c: clear 'first_chunk' in
 case of no pre-allocation
Message-ID: <20190608075548.GC19075@lst.de>
References: <20190606083410.32243-1-ming.lei@redhat.com> <20190606083410.32243-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606083410.32243-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
