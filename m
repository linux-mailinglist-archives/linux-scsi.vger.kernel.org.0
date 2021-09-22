Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1209541509B
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Sep 2021 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhIVTpO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Sep 2021 15:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhIVTpM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Sep 2021 15:45:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F676C061574
        for <linux-scsi@vger.kernel.org>; Wed, 22 Sep 2021 12:43:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x124so6127713oix.9
        for <linux-scsi@vger.kernel.org>; Wed, 22 Sep 2021 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NdfOI4pLAZV9M1l1OIkcn0omvnM6YyDLp+ahHmCFaKQ=;
        b=EK13E1LMKQXDOSrWwiQlV6RXcKUCr0OiIk3fMqxovr8WN7ZCT0unxHinFV8/z7660P
         DVFspN6xL1MRaaxzhYNYmKfBqUcAxP5Isd4q4wnpU9uYrVEOtV/kkLq0LAfykgo32v97
         Ru+99ghTmTyauq73Zti1b50+bLQIdTwFY+i3sPpGz6IDLNeyVc+Yg8hj8HVTH0+oa3Pd
         RROiYotHydbYUO9ynee4RQjKaRAmYYK+HLBp2kyJFigWCfgUNRGRyfUd2hUksT38cLJ0
         BjJGHhjcSSF+hyie99uZXEJYeUFKZusLPOVtPDPaxGV0ZmHrxs8kZfEx+7Xcu9VW6Dro
         U2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NdfOI4pLAZV9M1l1OIkcn0omvnM6YyDLp+ahHmCFaKQ=;
        b=iBORW3TU885donoOpdPQaQmMdVeZCu3auxdMtPl3e6JOQSjyoBbz1Y0F1WFs5BJAna
         OBJOcSWwFC3A0A9I+Xy+XXqpHwl2XarhoEDCCEVaX4oqlL2hbZN0ShPlLc/arpbGrHzv
         73CfnHYBdTmRbh/TVHab8fRec8Cemqy6kTKVOQp4UHWQ2rIj6XNaq5mTzqT+2edmnlxi
         hFN5qg3986u6Ofa0pt8y6u2G8ngNmSfZR+7fz80ROww+E1at1njcGkED4/usrE0Jt0gi
         C8LLG5aP8pXGGMACDcHQ2N0E0vYEzPHyuKWc3LQUUYJP6MqjCMlbPy1WPrdUWW+4MkHX
         +jzA==
X-Gm-Message-State: AOAM530TLCjEz7EC5/LMdXeXS4/6fQ1SjP4OB7JGPfvU/MQhWHAUwrZI
        UymZ3/jXNqH8kRcKhejrQZHxvZaaNJXqKz4Bhsw=
X-Google-Smtp-Source: ABdhPJxzTj9QWxaH6Oqy08RShfm9ElKcmlS+rPpTiHk8TNJZosbokoXF9QzDp9XR3imgfc7L93WLh9YFfyJjvJgpcSY=
X-Received: by 2002:aca:6108:: with SMTP id v8mr7319148oib.139.1632339821999;
 Wed, 22 Sep 2021 12:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:d038:0:0:0:0 with HTTP; Wed, 22 Sep 2021 12:43:41
 -0700 (PDT)
Reply-To: ahilhim@yandex.com
From:   Kirinec Zlatko <marrylynnwanne1@gmail.com>
Date:   Wed, 22 Sep 2021 12:43:41 -0700
Message-ID: <CAFk1P4SOiuKRszF7joVy=Ba41PzsfNGpaAvvopcgM7SvsDPwGg@mail.gmail.com>
Subject: Von Kirinec Zlatko
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Bitte entschuldigen Sie, dass ich nicht Ihre Erlaubnis eingeholt habe,
bevor Sie diese Mail an Sie senden. Ich bin Aahil Madrigal, wie geht
es dir bitte, es gibt ein sehr wichtiges Thema, das ich sehr dringend
mit dir teilen m=C3=B6chte
Dankesch=C3=B6n.
