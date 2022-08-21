Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E232B59B6E3
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Aug 2022 01:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiHUX7e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Aug 2022 19:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHUX7c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Aug 2022 19:59:32 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593421CFF3
        for <linux-scsi@vger.kernel.org>; Sun, 21 Aug 2022 16:59:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-33387bf0c4aso250859727b3.11
        for <linux-scsi@vger.kernel.org>; Sun, 21 Aug 2022 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iakKpydVW03vbxeLCirenXhojwC1hqumN0lNHPqWCdw=;
        b=nJ/vGqUSLa9DnWaKCjD4IYb997RrEHAGBhxGmihx/QBx82T4m8eMNNuu6XoWvgXBSo
         gjVKkm1cDI7EDRbgKJKB4cdtxx9uAAglLcJ/pDzr5DKWHnw2US1jSrkhOa6jbgq6oDr6
         9WcQ8O56soaEt6q1hcmqIgzL3cTvcn715ImCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iakKpydVW03vbxeLCirenXhojwC1hqumN0lNHPqWCdw=;
        b=JabdRCSwt+/I+1LrA8BsVhf/lsp/hxhTL82XZCJPKDw87qL03KeDIZ7HNe2yGa97Ga
         cYrn0W9DNDeoG0zPAXClPJW04QXvSYdbufxGRZQjtVJzEd7tZM+4r0tz05hAOQ/AL+IT
         WtxWn0uGn7+1jhaigi+QBa2QNKfP4hP5W7T3SXpPKIIFlt0V0OFeKXnmSST8OEV3Vrbh
         DIOuAQr1rFHgpX6yKsKkiVtJ6ERHCs/VNgiAYc4BVgOixC01kmlzp4paezzjX/JAmcZ6
         0l7knAAYbDdvRw1MX+P/PC5joAZWUxT7Efn2nerZG+qmL6pY04MB5uwQuYcJht1DzPoY
         V8gw==
X-Gm-Message-State: ACgBeo3QRtUuzMUey+oIYR211XGVKuJOpCAQvhxQmj6gBf1vjKUHbo3b
        ehGwKG0vpG732kV+TUnThF9DCeF4VeTgQ7xff9ttGQ==
X-Google-Smtp-Source: AA6agR4V/WyOk1XvcWEhBj39TlWJaZ1axBsZJ+5uENTDd124D1VWlbeX7EhdIys57P07RsrxTPWy0ThMFWOvBHQ5u88=
X-Received: by 2002:a81:c210:0:b0:339:7eb3:4ad7 with SMTP id
 z16-20020a81c210000000b003397eb34ad7mr8380019ywc.103.1661126370611; Sun, 21
 Aug 2022 16:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220815104739.v7.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <Yvnq5o5f+qp5zs1c@kroah.com>
In-Reply-To: <Yvnq5o5f+qp5zs1c@kroah.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Mon, 22 Aug 2022 09:59:19 +1000
Message-ID: <CAONX=-dc9Uj92SZXuhJOdJSBVYWAzNhx8__QQh8icB2D0ZM1=g@mail.gmail.com>
Subject: Re: [PATCH v7] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Greg,
Can you clarify what specifically is missing from the changelog?
The comment used to be on the "c" file, but now is moved to the
documentation. Is there anything specific missing?
Thanks,
Daniil

On Mon, Aug 15, 2022 at 4:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 15, 2022 at 10:48:03AM +1000, Daniil Lunev wrote:
> > Allows userspace to check if Clock Scaling and Write Booster are
> > supported.
> >
> > Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>
> Please provide a lot more information about this in the changelog text.
> What would you want to see here if you had to review this change?
>
> thanks,
>
> greg k-h
