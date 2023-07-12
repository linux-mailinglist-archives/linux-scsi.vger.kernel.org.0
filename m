Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805467509C2
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jul 2023 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjGLNkv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jul 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjGLNkt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Jul 2023 09:40:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65D319B4
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jul 2023 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jBtAqtTkPe7xSA8gIcOGPofAG5Ec6Godi3McG+Bj7TI=; b=ne4U33O6PpFN0GLvSBzWvdpMwS
        fqEB0JUvUajrnCGj0wimrRumDWvNjBni3q3H/klPnnmG4JXWtZNh2Y/Kr8ARlu6T6RA0Yo9YtWZmW
        VN5KR+qLiAlYcoVi3lgrmu+MPFVYCx1sUWGRxy9IytLpG/Q9I0LQkmPi6tAvlA5H9U2CkWaHcwM8f
        9xwHpByfBwJrELoXbx8GycAAGgOUrENgCNm4c5QZcx25O/liCF+a+4efNKt/9ndN5qMe8sUd9Pzr8
        9wCz4R6K1OrD+MGsu5s+hBG08OoMrhLMZrhPUZ2QGHJiE6d75hsds9crd8et3iAvcoi5+iwwNPmoT
        fWOo5qDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJa4q-0005Yd-38;
        Wed, 12 Jul 2023 13:40:20 +0000
Date:   Wed, 12 Jul 2023 06:40:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
        Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <ZK6tRDwxgbyYfv2v@infradead.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
 <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 12, 2023 at 10:28:00AM +0200, Stefano Garzarella wrote:
> The problem is that the SCSI stack does not send this command, so we
> should do it in the driver. In fact we do it for
> VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).

No, you should absolutely no do it in the driver.  The fact that
virtio-scsi even tries to do some of its own LUN scanning is
problematic and should have never happened.
