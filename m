Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628556C7887
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Mar 2023 08:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCXHMg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Mar 2023 03:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCXHMe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Mar 2023 03:12:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3725BBF
        for <linux-scsi@vger.kernel.org>; Fri, 24 Mar 2023 00:12:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so4341767eda.0
        for <linux-scsi@vger.kernel.org>; Fri, 24 Mar 2023 00:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679641950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHYARhcu7fqeGh+Mo9qe8pAsnwrLQZJjJYTNVl5/co0=;
        b=eQ/gIFjOOzT1h/PfMelahxCE+q5DGqaPZzYpkuWS8Ix50crh+8pLukozCcpxvnN1lN
         Rdwy0u6DYTq0gHaf+n5q65JduEvxaCK/TZzYMp6uI7n6DD8N3Kw1i9bT9de6O9LNSK4U
         JhxUYb6OL65cMdC2sMceG64Tz43ZBnCKhKjahnwMpGp0xrPFIyl1+Kb65j20+ja1tu79
         PW/oSDbUmfpV+A8hH2x/MQWi22+4MviE4dpyMLpayOys3ctYUtv5Y/SPO8lH4Q+8O3aQ
         ZxZrG2MAX6NnYhQcP98DRhzBSMXt+Zzxm7h7rDx1LzZPkwBAOTFCwqoVddQyJovSS0Df
         M8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679641950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHYARhcu7fqeGh+Mo9qe8pAsnwrLQZJjJYTNVl5/co0=;
        b=N6h8H6KLXTfQZhzpDMf8ewQORQ57nuxS6wR7JsaKSik2MQZPbl20sN0XXgE3Lit4E2
         hBtOkS2zja048175lQKf+eb3mCkw7WZghPcpnugic8Ve0qE/HIgZQ+km6XXQFl4zh+sS
         3GYIfVnFdCmeQv+O5wCdqJ+q3mc3XBB5w3swp6EGLwp/TkwRDM0yRs4UzarmrQtWjJG3
         mqeDIejxVpDPQw8fr0Tl7I2c0ItUlm/aQ57EsgQHC1G7UljlcZkoi3FSdbJQE2/g+aeG
         +FIcJwDHS4F7jD4EONnfElpssZ9vIMJl597Nb5vhYGToCx8PWQdSpElVe/HkJ1vZkmEe
         5R5w==
X-Gm-Message-State: AAQBX9dgDr5re4LwAYjYZsXzVk4objHfKXf8DpHVhwS43zQMpuSolzfX
        BlI2DyXpB8yKs5Ak8y45IfzrUw==
X-Google-Smtp-Source: AKy350ZgsGG14ir1cibTF8MCHhqvpjZXYXE75aJ1CLRl2+x6YiTaEEn8kXqhVNjwE/4L8/Vzwx87Yg==
X-Received: by 2002:a17:906:54cc:b0:932:c315:b0d with SMTP id c12-20020a17090654cc00b00932c3150b0dmr1642754ejp.34.1679641949969;
        Fri, 24 Mar 2023 00:12:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ce50:243f:54cc:5373? ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm7128368ejc.100.2023.03.24.00.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 00:12:29 -0700 (PDT)
Message-ID: <3356ecee-4e6c-8707-c26e-73329b4f4728@linaro.org>
Date:   Fri, 24 Mar 2023 08:12:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/8] arm64: dts: qcom: sm8450: remove invalid properties
 in cluster-sleep nodes
Content-Language: en-US
To:     neil.armstrong@linaro.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-4-3ead1e418fe4@linaro.org>
 <0bcad5cc-112f-386c-b70e-146530ac4898@linaro.org>
 <215efc34-68bf-53d7-2191-a5132c3d2198@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <215efc34-68bf-53d7-2191-a5132c3d2198@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 23/03/2023 14:14, Neil Armstrong wrote:
> On 23/03/2023 11:51, Krzysztof Kozlowski wrote:
>> On 23/03/2023 11:25, Neil Armstrong wrote:
>>> Fixes the following DT bindings check error:
>>> domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes:
>>> 'pinctrl-[0-9]+'
>>> domain-idle-states: cluster-sleep-1: 'idle-state-name', 'local-timer-stop' do not match any of the regexes:
>>> 'pinctrl-[0-9]+'
>>
>> I don't get from the commit msg why these properties are not correct
>> here. The idle states allow them, so maybe something is missing in the
>> binding? At least commit msg should explain this.
> 
> The domain-idle-states bindings doesn't document those 2 properties, so perhaps it's missing ?

Ah, you are right. These were copied from CPU idle states, so here they
do not make sense.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

