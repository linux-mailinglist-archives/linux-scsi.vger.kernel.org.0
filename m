Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43735186BD
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiECOhC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 May 2022 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiECOhB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 May 2022 10:37:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1731DEC
        for <linux-scsi@vger.kernel.org>; Tue,  3 May 2022 07:33:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A5F967373; Tue,  3 May 2022 16:33:25 +0200 (CEST)
Date:   Tue, 3 May 2022 16:33:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 10/11] fas216: Rework device reset to not rely on SCSI
 command pointer
Message-ID: <20220503143325.GH24492@lst.de>
References: <20220502215416.5351-1-hare@suse.de> <20220502215416.5351-11-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502215416.5351-11-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eww, the function pointer abuse in this drive is rather gross.

But the changes looks ok to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
