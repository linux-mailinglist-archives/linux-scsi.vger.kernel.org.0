Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8671BFE
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfGWPlc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jul 2019 11:41:32 -0400
Received: from verein.lst.de ([213.95.11.211]:42811 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfGWPlc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 23 Jul 2019 11:41:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FE7868BFE; Tue, 23 Jul 2019 17:41:30 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:41:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/3] fcoe: avoid memset across pointer boundaries
Message-ID: <20190723154130.GG720@lst.de>
References: <20190722062231.115865-1-hare@suse.de> <20190722062231.115865-3-hare@suse.de> <20190722115013.GC32052@lst.de> <4c448b5f-2db5-7732-3659-3e4915c94c29@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c448b5f-2db5-7732-3659-3e4915c94c29@interlog.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 22, 2019 at 02:50:50PM -0400, Douglas Gilbert wrote:
> Hmmm, "non-empty", is that a GNU extension?

Yes, empty initializers are a GNU extension.  One that is pretty heavily
used in the kernel.
