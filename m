Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8B3F29A3
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Aug 2021 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhHTJ4s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Aug 2021 05:56:48 -0400
Received: from verein.lst.de ([213.95.11.211]:40396 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235321AbhHTJ4r (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Aug 2021 05:56:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 66B7367373; Fri, 20 Aug 2021 11:56:08 +0200 (CEST)
Date:   Fri, 20 Aug 2021 11:56:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 3/3] ncr53c8xx: Remove unused code
Message-ID: <20210820095608.GC9733@lst.de>
References: <20210820095405.12801-1-hare@suse.de> <20210820095405.12801-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820095405.12801-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
