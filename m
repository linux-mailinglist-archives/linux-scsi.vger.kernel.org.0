Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6758F9C6
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Aug 2022 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiHKJKj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Aug 2022 05:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiHKJKh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Aug 2022 05:10:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0918E027
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 02:10:20 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i62so27309665yba.5
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=MxU4fJ4El5xIikQ69s5+V+M7YC/oCSbBwTvPMsApxc8=;
        b=eJ41FUBoSkZFceExylhSWxZJfGxB4pQvaElWVnVxLYIsl6ICOMU4nBiLgY+oqgZj08
         8FpgBiX+xqeMGytljz1oDItchxrm0WVkJcKlnfs6yewpRtE0k8xYVxRY6a4eGC5+pZhL
         kS4QToMeCI9VAjoTVGgDz+y6uXBFnjv8ghWtUT69YVhWcL9GzZGTbSgNJu8s1ZTXgfoM
         ecLIXEWyo+ZqTS4ED+Lg2Yx0Syii68jvgTDq07mI16V63IBqDcViIKKgBkkjSd+TwGkW
         bdyFlNwyNf5BO4qIkgSWNSfoXUJQIQ/ZLHoV0E6/H340fNlfpk+hD2pJd50/zY62OXAT
         48VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=MxU4fJ4El5xIikQ69s5+V+M7YC/oCSbBwTvPMsApxc8=;
        b=WhJ2gvR6FTnj1SnlbxCE/HXHwJo1HHtGa5LbX0Bk/8yLbc7sPur7IKb1b2kBq4vCsr
         KMrMqXzDKn1l0kutc7f6aQJbFvHBvrJEeGulMdx3O/zisahfF7723r0tOn6ypjkmyV1d
         uCGHPAke/A0pOxOWsHbVSDg7Hst8gchAiLsvUnGNzOnQE5dEEj1cPIlaUBosMNZssYqx
         4JWzPuHdGMhXen29PfxeV4R3OQ9uYjXr5a8ybEsJz2axl35GoS0EcJrtau4TAhbQrJq8
         K26+lRxjjA6kSej8H1no1El7ajtwXtTjhGOUux5FZyUKO/+aSY5bTK7oD7xbHIgdZShS
         0WnA==
X-Gm-Message-State: ACgBeo2EYXhPFcozqlSwcomDcLOVVnfUgHf8iwKmLX1QZv1JJHi/Gt10
        ja6JwtzfcoEZOLZK282FqyZbxD9b31d8kUqeQTQ=
X-Google-Smtp-Source: AA6agR4il/eThoQ6fGnx8sGfKo2WbUqpkV7Gq5QXxHNXTomrWOuHRyyftRYvloICvbcrQa1+jM/z8wHSKzfQRWOpzmY=
X-Received: by 2002:a25:c287:0:b0:67c:347e:294c with SMTP id
 s129-20020a25c287000000b0067c347e294cmr9468321ybf.317.1660209019214; Thu, 11
 Aug 2022 02:10:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:470f:b0:18d:c935:c926 with HTTP; Thu, 11 Aug 2022
 02:10:18 -0700 (PDT)
Reply-To: mr.ahodolevi@gmail.com
From:   George Levi <mr.koffiwillames@gmail.com>
Date:   Thu, 11 Aug 2022 09:10:18 +0000
Message-ID: <CAMgiTmZYFDaDJydW86ZQ8Uj+xESGHcNW6JTD0vOFqHHwu43vYw@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr. George Levi
