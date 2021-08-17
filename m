Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C423EEC3A
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhHQMNn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 08:13:43 -0400
Received: from verein.lst.de ([213.95.11.211]:58268 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236233AbhHQMNn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Aug 2021 08:13:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91E1F67357; Tue, 17 Aug 2021 14:13:07 +0200 (CEST)
Date:   Tue, 17 Aug 2021 14:13:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHv2 00/51] SCSI EH argument reshuffle part II
Message-ID: <20210817121307.GA30436@lst.de>
References: <20210817091456.73342-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817091456.73342-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

First, thanks for resurrecting the series.

Second, this giant patchbomb is almost impossible to review.  It might
make sense to resend what is the prep patches without the prototype
changes after the first round of review - maybe we can squeeze those
into 5.15 still and do the heavy lifting with another series per
actually changes method or so.
