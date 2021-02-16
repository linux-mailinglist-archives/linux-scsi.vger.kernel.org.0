Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81CA31C77E
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Feb 2021 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhBPInR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Feb 2021 03:43:17 -0500
Received: from verein.lst.de ([213.95.11.211]:40323 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhBPIlS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Feb 2021 03:41:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 320186736F; Tue, 16 Feb 2021 09:40:06 +0100 (CET)
Date:   Tue, 16 Feb 2021 09:40:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     mst@redhat.com, stefanha@redhat.com, Chaitanya.Kulkarni@wdc.com,
        hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 14/25] target: remove target_submit_cmd_map_sgls
Message-ID: <20210216084006.GA23615@lst.de>
References: <20210212072642.17520-1-michael.christie@oracle.com> <20210212072642.17520-15-michael.christie@oracle.com> <6cf91481-5c5d-0577-85f8-a454135581cc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf91481-5c5d-0577-85f8-a454135581cc@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Feb 12, 2021 at 04:17:34PM -0600, Mike Christie wrote:
> Hey Christoph, I think I misinterpreted your review comment about adding a
> warning here. I thought you wanted it so we could detect there was a problem
> early on. We can't do that, but I can do:
> 
> +	rc = target_init_cmd(se_cmd, se_sess, sense, unpacked_lun, data_length,
> +			     task_attr, data_dir, flags);
> +	WARN(rc, "Invalid target_submit_cmd use. Driver must not use target_stop_session or call target_init_cmd directly.\n");
> 
> and we can at least warn someone at some point.

Yes, that is what I meant.
