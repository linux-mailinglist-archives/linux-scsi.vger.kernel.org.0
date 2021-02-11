Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A28318E9A
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Feb 2021 16:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhBKPal (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Feb 2021 10:30:41 -0500
Received: from verein.lst.de ([213.95.11.211]:55823 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhBKP1E (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Feb 2021 10:27:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECE7F68C65; Thu, 11 Feb 2021 16:14:05 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:14:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com,
        Michael Cyr <mikecyr@linux.ibm.com>
Subject: Re: [PATCH 06/14] ibmvscsi_tgt: Convert to new submission API
Message-ID: <20210211151405.GE22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-7-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-7-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Feb 11, 2021 at 06:27:20AM -0600, Mike Christie wrote:
> target_submit_cmd is now only for simple drivers that do their
> own sync during shutdown and do not use target_stop_session. It
> will never return a failure, so we can remove that code from
> the driver.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
